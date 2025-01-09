// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.commerce.orders as orders;

// Configuration for HubSpot API client credentials
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

public function main() returns error? {
    // Initialize the HubSpot client with the given configuration
    orders:ConnectionConfig config = {
        auth: {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };
    final orders:Client hubspotClient = check new orders:Client(
        config, serviceUrl = "https://api.hubapi.com/crm/v3/objects");
    io:println("HubSpot Client initialized successfully.");
    check handleOrderManagement(hubspotClient);
}

function handleOrderManagement(orders:Client hubspotClient) returns error? {
    io:println("Starting Order Management...");
    string|error? newOrderId = "";
    newOrderId = createOrder(hubspotClient);
    if newOrderId is string {
        check readOrder(hubspotClient, newOrderId);
        check updateOrder(hubspotClient, newOrderId);
        check deleteOrder(hubspotClient, newOrderId);
    } else {
        io:println("Failed to create order.");
        io:println("Order Management Exited With Error.");
    }
    io:println("Order Management Completed.");
}

// Create a new order
function createOrder(orders:Client hubspotClient) returns string|error? {
    orders:SimplePublicObjectInputForCreate newOrder =
    {
        associations: [
            {
                to: {
                    id: "31440573867"
                },
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 512
                    }
                ]
            }
        ],
        objectWriteTraceId: null,
        properties: {
            "hs_order_name": "Camping supplies",
            "hs_currency_code": "USD",
            "hs_source_store": "REI - Portland",
            "hs_fulfillment_status": "Packing",
            "hs_shipping_address_city": "Portland",
            "hs_shipping_address_state": "Maine",
            "hs_shipping_address_street": "123 Fake Street"
        }
    };
    orders:SimplePublicObject|error response = hubspotClient->/orders.post(newOrder);
    if response is orders:SimplePublicObject {
        io:println("Order created successfully with ID: ", response.id);
        return response.id;
    } else {
        io:println("Failed to create order.");
        return error("Failed to create order.");
    }
}

function readOrder(orders:Client hubspotClient, string orderId) returns error? {
    var response = hubspotClient->/orders/[orderId];
    if response is orders:SimplePublicObjectWithAssociations {
        io:println("Order details retrieved: ", response);
    } else {
        io:println("Failed to retrieve order with ID: ", orderId);
    }
}

function updateOrder(orders:Client hubspotClient, string orderId) returns error? {
    orders:SimplePublicObjectInput updateDetails = {
        properties: {
            "hs_fulfillment_status": "Shipped"
        }
    };
    var response = hubspotClient->/orders/[orderId].patch(updateDetails);
    if response is orders:SimplePublicObject {
        io:println("Order updated successfully with ID: ", response.id);
    } else {
        io:println("Failed to update order with ID: ", orderId);
    }
}

function deleteOrder(orders:Client hubspotClient, string orderId) returns error? {
    var response = hubspotClient->/orders/[orderId].delete();
    if response is http:Response {
        io:println("Order deleted successfully with status: ", response.statusCode);
    } else {
        io:println("Failed to delete order with ID: ", orderId);
    }
}

