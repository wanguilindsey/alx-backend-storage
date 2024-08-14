#!/usr/bin/env python3
"""
Caching request module.
"""
import redis
import requests
from functools import wraps
from typing import Callable


def track_get_page(fn: Callable) -> Callable:
    """Decorator for get_page to track URL access and cache responses."""
    @wraps(fn)
    def wrapper(url: str) -> str:
        """Wrapper that:
        - Checks whether a URL's data is cached.
        - Tracks how many times get_page is called.
        """
        client = redis.Redis()
        client.incr(f'count:{url}')
        cached_page = client.get(f'{url}')
        if cached_page:
            return cached_page.decode('utf-8')
        response = fn(url)
        client.set(f'{url}', response, 10)
        return response
    return wrapper


@track_get_page
def get_page(url: str) -> str:
    """Make an HTTP request to a given URL."""
    response = requests.get(url)
    return response.text
