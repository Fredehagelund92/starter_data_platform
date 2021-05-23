# Starter Data Platform

![flow](https://user-images.githubusercontent.com/5653787/119267491-28bd3b00-bbef-11eb-8b1d-91b8b294b83d.png)


This repository provides a starting point for implementing a modern open source data platform. Data has become an essential part of organizations and their decision making process. The idea is to have a central repository with all the data, so analysts can provide meaningful analytics for the rest of the organization.

This project will be used to explain and show how an data platform can be established with open-source industry standard products. The idea is to simplify the process of establishing a data platform, so we can make it more cost effective.


Need info or have feedback? Do not hesitate to  [create an issue](https://github.com/Fredehagelund92/starter_data_platform/issues/new)

-----


## Table of contents
- [Starter Data Platform](#starter-data-platform)
  - [Table of contents](#table-of-contents)
  - [Data Stack](#data-stack)
    - [Storage](#storage)
    - [Extract](#extract)
    - [Transformation](#transformation)
    - [Orchestration](#orchestration)
    - [Visualization](#visualization)
  - [Getting Started](#getting-started)
    - [Setup database](#setup-database)
    - [Setup Airbyte](#setup-airbyte)
    - [Replicate a source](#replicate-a-source)
    - [Clone project](#clone-project)
      - [Folder structure](#folder-structure)
    - [Install prefect](#install-prefect)
      - [Deploy dags](#deploy-dags)

<br />

## Data Stack
___
### Storage

### Extract
[Airbyte](https://github.com/airbytehq/airbyte)  is a new open-source application that is creating the new standard for data integration. The CDK makes it easy to integrate your data from various datasources. There are other tools like Meltano, Kiba etc. however airbytes community is growing rapidly and its so easy to get started. The data integration is heavily influenced by singer.

When starting a new data project i always start by integrating following data:

* Holidays (Used to create a calendar/date dimension. This makes it way easier when supporting multiple countries)
* Addresses (Often source systems does not provide geospatial and detailed address information.)
* Exchange rates (Again if supporting multiple countries it might be needed to have metrics converted)

This enables me to quickly get started and generally it is not a problem, since storage is cheap.

<br />

### Transformation
[dbt](https://github.com/fishtown-analytics/dbt) introduces new standards to the data engineering and analyst space. For years people have been using GUI tools like Talend, SSIS, Pentaho, Alteryx etc. If you are familiar with one of these tools it can be rather quick to develop jobs. Personally i always end up banging my head against the wall due to following problems:

* Components are not very flexible and workarounds are often needed.
* Version control can be a mess due to project files.
* CI/CD for your data pipelines is limited or time consuming.

With dbt engineers and analysts are able to do their transformations using select statements and jinja macros. These statements are called "models" and can be build using the dbt CLI. dbt will then compile the models and execute it based on the desired behaviouclick 8.0.1r:

* Materialize a full table - full refresh
* Materialize a view - overwrite
* Append to existing table - incremental
* Ephemeral - data will not be stored in your database, but can instead be used as a common table expression in other models

The dbt framework also provide functionalities like:

* Documentation of models, datasources etx.
* Data lineage graph of relationships between models
* Schema and data tests using assertation (unique, not_null, accepted_values etc.)

<br />

### Orchestration
[Prefect](https://github.com/PrefectHQ/prefect)

<br />

### Visualization
[Redash](https://github.com/apache/airflow) is one of the two big Open-source applications for visualization. The other one is Metabase, which also have a large following. Whether you pick one or another depends on the organization and its competencies.


Redash reports are build directly on top SQL queries and have a lot of different types of visualizations. Metabase is more point and click type of reporting, which makes it easier for self-service setup.

<br />

## Getting Started

____

### Setup database

Start by installing Materialize using [these instructions](https://materialize.com/docs/install/).

there are several ways to 


### Setup Airbyte


### Replicate a source


### Clone project


#### Folder structure





### Install prefect

#### Deploy dags




