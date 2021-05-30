import os

from dagster import pipeline, solid

from orchestration.redash import get_queries
from orchestration.redash import save_queries



@solid
def get_queries():
    redash_url = os.getenv('REDASH_URL')
    redash_api_key = os.getenv('REDASH_API_KEY')
    return get_queries(redash_url, redash_api_key)


@solid
def hello(context, name: str):
    context.log.info(f"Hello, {name}!")


@pipeline
def hello_pipeline():
    hello(get_name())