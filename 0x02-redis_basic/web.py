#!/usr/bin/env python3
"""
Web caching and request tracking module.
"""
import redis
import requests
from functools import wraps
from typing import Callable


def track_get_page(fn: Callable) -> Callable:
    """Decorator to track URL access and cache responses with expiration."""
    @wraps(fn)
    def wrapper(url: str) -> str:
        """Wrapper that:
        - Tracks how many times a URL is accessed in Redis.
        - Caches the response with a 10-second expiration.
        """
        client = redis.Redis()
        client.incr(f'count:{url}')
        cached_page = client.get(f'{url}')
        if cached_page:
            return cached_page.decode('utf-8')
        response = fn(url)
        client.setex(f'{url}', 10, response)
        return response
    return wrapper


@track_get_page
def get_page(url: str) -> str:
    """Fetch HTML content from a given URL."""
    response = requests.get(url)
    return response.text


if __name__ == "__main__":
    url = "http://slowwly.robertomurray.co.uk"
    print(get_page(url))
