<!-- PROJECT LOGO -->
<br />

  <h1 align="center">Starter Data Platform</h1>



  <p align="center">
    An awesome project that will help taking the first step on your journey toward data-driven decisions.
    <br />
    <br />
  </p>

<div align="center">
    <a  href="https://github.com/Fredehagelund92/starter_data_platform/stargazers"><img src="https://img.shields.io/github/stars/Fredehagelund92/starter_data_platform" alt="Stars Badge"/></a>
    <a href="https://github.com/Fredehagelund92/starter_data_platform/network/members"><img src="https://img.shields.io/github/forks/Fredehagelund92/starter_data_platform" alt="Forks Badge"/></a>
    <a href="https://github.com/Fredehagelund92/starter_data_platform/pulls"><img src="https://img.shields.io/github/issues-pr/Fredehagelund92/starter_data_platform" alt="Pull Requests Badge"/></a>
    <a href="https://github.com/Fredehagelund92/starter_data_platform/issues"><img src="https://img.shields.io/github/issues/Fredehagelund92/starter_data_platform" alt="Issues Badge"/></a>
    <a href="https://github.com/Fredehagelund92/starter_data_platform/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/Fredehagelund92/starter_data_platform?color=2b9348"></a>
    <a href="https://github.com/Fredehagelund92/starter_data_platform/blob/master/LICENSE"><img src="https://img.shields.io/github/license/Fredehagelund92/starter_data_platform?color=%232b9348" alt="License Badge"/></a>
    <br />
    <br />
</div>



# About

![flow](https://user-images.githubusercontent.com/5653787/119267491-28bd3b00-bbef-11eb-8b1d-91b8b294b83d.png)


This repository provides a starting point for implementing a modern open source data platform. Data has become an essential part of organizations and their decision making process. Having an central repository with all the data, enables analysts to provide meaningful analytics for the rest of the organization.

This project will be used to explain and show how an data platform can be established with only open-source products.


Need info or have feedback? Do not hesitate to  [create an issue](https://github.com/Fredehagelund92/starter_data_platform/issues/new)

<br />

# Table of contents
- [About](#about)
- [Table of contents](#table-of-contents)
- [Components](#components)
  - [Storage](#storage)
  - [Extract](#extract)
  - [Transformation](#transformation)
  - [Orchestration](#orchestration)
  - [Visualization](#visualization)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
  - [Setup Materialize](#setup-materialize)
  - [Setup Airbyte](#setup-airbyte)
  - [Setup dbt project](#setup-dbt-project)
  - [Setup Prefect](#setup-prefect)
    - [Clone project](#clone-project)
      - [Folder structure](#folder-structure)
    - [Install prefect](#install-prefect)
      - [Deploy dags](#deploy-dags)
  - [Development](#development)

<br />

# Components

## Storage

## Extract
[Airbyte](https://github.com/airbytehq/airbyte)  is a new open-source application that is creating the new standard for data integration. The CDK makes it easy to integrate your data from various datasources. There are other tools like Meltano, Kiba etc. however airbytes community is growing rapidly and its so easy to get started. The data integration is heavily influenced by singer.

When starting a new data project i always start by integrating following data:

* Holidays (Used to create a calendar/date dimension. This makes it way easier when supporting multiple countries)
* Addresses (Often source systems does not provide geospatial and detailed address information.)
* Exchange rates (Again if supporting multiple countries it might be needed to have metrics converted)

This enables me to quickly get started and generally it is not a problem, since storage is cheap.

<br />

## Transformation
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

## Orchestration
[Prefect](https://github.com/PrefectHQ/prefect)

<br />

## Visualization
[Redash](https://github.com/apache/airflow) is one of the two big Open-source applications for visualization. The other one is Metabase, which also have a large following. Whether you pick one or another depends on the organization and its competencies.


Redash reports are build directly on top SQL queries and have a lot of different types of visualizations. Metabase is more point and click type of reporting, which makes it easier for self-service setup.

<br />

# Requirements

![servers](https://user-images.githubusercontent.com/5653787/119343188-645f1000-bc96-11eb-8e2a-06aa2f642aa0.png)


The minimum requirement for servers are as follows:

* Materialization server
* Dagster server
* Airbyte server

The specific technical requirements heavily depends depends on various factors like data volume, number of analysts etc. If you want more details please check out the specific documentation of the applications.

For CI/CD i prefer a local [Github Actions](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners) runner. For most cases it should be sufficient to install it on the Prefect server.

<br />

# Getting Started

## Setup Materialize
Start by installing Materialize on the first machine using [these instructions](https://materialize.com/docs/install/).

<br />

1. Login to your instance

    ```
    psql -U materialize -h localhost -p 6875 materialize
    ```

2. Create databases

    ```
    create database raw;
    create database production;
    create database development;
    ```

## Setup Airbyte
Start by installing Airbyte on the first machine using [these instructions](https://docs.airbyte.io/quickstart/deploy-airbyte).

<br />


1. Login to your instance

    ```
    psql -U materialize -h localhost -p 6875 materialize
    ```

## Setup dbt project







## Setup Prefect






### Clone project


#### Folder structure

### Install prefect

#### Deploy dags



## Development



