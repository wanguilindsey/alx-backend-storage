#!/usr/bin/env python3
""" MongoDB operations with Python using pymongo """

def schools_by_topic(mongo_collection, topic):
    """ Returns a list of schools that have a specific topic """
    documents = mongo_collection.find({"topics": topic})
    return list(documents)
