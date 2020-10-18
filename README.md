# terraform-pact-contract

Contract testing is a way to ensure that services (such as an API
provider and a client) can communicate with each other. Without contract
testing, the only way to know that services can communicate is by using
expensive and brittle integration tests.

This module creates two Pact Broker webhooks enabling both an API consumer to
invoke verification tests within the API provider CI pipeline, and for those
verification results to trigger a success/failure within the API consumer
build.

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](https://git-scm.com/)
* [terraform](https://www.terraform.io/) (0.13.4)

## Installation

* `git clone <repository-url>` this repository
* `cd terraform-pact-contract`

## Making Changes

Making changes to the infrastructure requires editing HashiCorp configuration
language files. These describe the desired state of the infrastructure and are
used to inform providers how to query configured APIs.

Changes must be made in a separate branch and a pull request made against the
master branch. When this happens a GitHub action will ensure the changes meet
formatting standards and validate that the configuration is in a consistent
state.
