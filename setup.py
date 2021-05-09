from setuptools import setup

requires = [
    "dbt==0.19.1",
    "meltano==1.71.0"
]

setup(
    name="data platform",
    version="1.0",
    description="dbt module for development",
    author="Frederik Hagelund",
    author_email="name@email.com,
    install_requires=requires,
)
