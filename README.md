# Ballerina HubSpot CRM Commerce Orders connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/hubspot.crm.commerce.orders.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%hubspot.crm.commerce.orders)

## Overview

[HubSpot](https://www.hubspot.com) is an AI-powered customer relationship management (CRM) platform.

The `ballerinax/hubspot.crm.commerce.orders` package offers APIs to connect and interact with [HubSpot API for CRM Commerce Orders](https://developers.hubspot.com/docs/reference/api/crm/commerce/orders) endpoints, specifically based on [HubSpot CRM Commerce Orders REST API](https://developers.hubspot.com/docs/reference/api).

## Setup guide

To use the HubSpot Commerce Orders connector, you must have access to the HubSpot API through a HubSpot developer account and a HubSpot App under it. Therefore you need to register for a developer account at HubSpot if you don't have one already.

### Step 1: Create/Login to a HubSpot Developer Account

If you have an account already, go to the [HubSpot developer portal](https://app.hubspot.com/)

If you don't have a HubSpot Developer Account you can sign up to a free account [here](https://developers.hubspot.com/get-started)

### Step 2 (Optional): Create a Developer Test Account

Within app developer accounts, you can create [developer test account](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) under your account to test apps and integrations without affecting any real HubSpot data.

>**Note:** These accounts are only for development and testing purposes. In production you should not use Developer Test Accounts.

1. Go to Test Account section from the left sidebar.

   ![Hubspot Developer Portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/test_acc_1.png)

2. Click Create developer test account.

   ![Hubspot Developer Test Account](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/test_acc_2.png)

3. In the dialogue box, give a name to your test account and click create.

   ![Hubspot Developer Test Account](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/test_acc_3.png)

### Step 3: Create a HubSpot App under your account

1. In your developer account, navigate to the "Apps" section. Click on "Create App"

   ![Hubspot Create App](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/create_app_1.png)

2. Provide the necessary details, including the app name and description.

### Step 4: Configure the Authentication Flow

1. Move to the Auth Tab. (Second tab next to App Info)

   ![Hubspot Developer Config Auth](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/auth_section.png)

2. In the Scopes section, add the following scope for your app using the "Add new scope" button.

   - `crm.objects.orders.read`
   - `crm.objects.orders.write`
   - `crm.objects.deals.read`
   - `crm.objects.deals.write`
   - `crm.objects.carts.read`
   - `crm.objects.commercepayments.read`
   - `crm.objects.companies.read`
   - `crm.objects.contacts.read`
   - `crm.objects.invoices.read`
   - `crm.objects.line_items.read`
   - `crm.objects.quotes.read`
   - `crm.objects.subscriptions.read`

   ![Hubspot Developer App Add Scopes](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/scopes.png)

3. Add your Redirect URI in the relevant section. You can also use `localhost` addresses for local development purposes. Click Create App.

   ![Hubspot Create Developer App](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/create_app_final.png)

### Step 5: Get your Client ID and Client Secret

- Navigate to the Auth section of your app. Make sure to save the provided Client ID and Client Secret.

  ![Hubspot Get Credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/get_credentials.png)

### Step 6: Setup Authentication Flow

Before proceeding with the Quickstart, ensure you have obtained the Access Token using the following steps:

1. Create an authorization URL using the following format:

   ```
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>`, and `<YOUR_SCOPES>` with your specific value.

   ![Hubspot Get Auth Code](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/main/docs/setup/resources/install_app.png)

2. A code will be displayed in the browser. Copy the code.

3. Run the following curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>`, and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the above step 3 as the `<CODE>`.

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command will return the access token necessary for API calls.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```

4. Store the access token securely for use in your application.

## Quickstart

To use the `HubSpot Commerce Orders` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `hubspot.crm.commerce.orders` module and `oauth2` module.

```ballerina
import ballerina/oauth2;
import ballerinax/hubspot.crm.commerce.orders as orders;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

   ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
   ```

2. Instantiate a `orders:ConnectionConfig` with the obtained credentials and initialize the connector with it.

   ```ballerina
   configurable string clientId = ?;
   configurable string clientSecret = ?;
   configurable string refreshToken = ?;

   final orders:ConnectionConfig config = {
       auth : {
           clientId,
           clientSecret,
           refreshToken,
           credentialBearer: oauth2:POST_BODY_BEARER
       }
   };
   final orders:Client baseClient = check new (config);
   ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample use case is shown below.

#### Read an order by ID

```ballerina
public function main() returns error? {
     orders:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging listOfOrdersResponse = check baseClient->/orders;
}
```

## Examples

The `HubSpot CRM Commerce Orders` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/module-ballerinax-hubspot.crm.commerce.orders/tree/main/examples/), covering the following use cases:

1. [Batch Operations](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/tree/main/examples/batch-operations) - Perform Batch operations on Orders in HubSpot
2. [Order Management](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/tree/main/examples/order-management) - Perform CRUD operations on Orders in HubSpot
3. [Search Operation](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.orders/tree/main/examples/search-operation) - Perform Search operations on Orders in HubSpot

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`hubspot.crm.commerce.orders` package](https://central.ballerina.io/ballerinax/hubspot.crm.commerce.orders/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
