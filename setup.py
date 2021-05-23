from setuptools import setup

requires = [
    "dbt==0.19.1",
    "requests==2.25.1",
    "click==8.0.1"
]

setup(
    name="data platform",
    version="1.0",
    description="dbt module for development",
    author="Frederik Hagelund",
    author_email="name@email.com",
    install_requires=requires,
)
