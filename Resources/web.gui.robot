########################################################
# Author: Jonathan Alexander Gibson
# Date: November 29, 2021
# Execution Command: N/A
# Credit: Udemy Course - https://www.udemy.com/course/robot-framework-level-1/
########################################################

*** Settings ***
Documentation  Suite specifically for testing the Amazon website GUI.

Resource  ./PO/cart.robot
Resource  ./PO/landing-page.robot
Resource  ./PO/product.robot
Resource  ./PO/search-results.robot
Resource  ./PO/sign-in.robot
Resource  ./PO/top-nav.robot

*** Keywords ***
Search for Products
    [Arguments]  ${url}  ${search_term}
    landing-page.Load  ${url}
    landing-page.Verify Page Loaded
    top-nav.Search for Products  ${search_term}
    search-results.Verify Search Completed  ${search_term}

Select Product from Search Results
    search-results.Click Product link
    product.Verify Page Loaded

Add Product to Cart
    product.Add to Cart
    cart.Verify Product Added

Begin Checkout
    cart.Proceed to Checkout
    sign-in.Verify Page Loaded

Begin Login
    [Arguments]  ${url}
    landing-page.Load  ${url}
    landing-page.Verify Page Loaded
    top-nav.View Account

Submit "Email" Value
    [Arguments]  ${email}
    sign-in.Fill "Email" Field  ${email}
    sign-in.Click "Continue" Button

Verify "Email" Error
    sign-in.Verify Invalid Email
