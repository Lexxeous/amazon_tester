########################################################
# Author: Jonathan Alexander Gibson
# Date: November 29, 2021
# Execution Command: N/A
# Credit: Udemy Course - https://www.udemy.com/course/robot-framework-level-1/
########################################################

*** Settings ***
Documentation  Gherkin-based suite specifically for testing the Amazon website GUI.

Resource  ./PO/cart.robot
Resource  ./PO/landing-page.robot
Resource  ./PO/product.robot
Resource  ./PO/search-results.robot
Resource  ./PO/sign-in.robot
Resource  ./PO/top-nav.robot

*** Keywords ***
user is not logged in
    Log  Check to see whether user is logged in

user searches for products
    [Arguments]  ${url}  ${search_term}
    landing-page.Load  ${url}
    top-nav.Search for Products  ${search_term}

search results contains relevant products
    [Arguments]  ${search_term}
    search-results.Verify Search Completed  ${search_term}

user selects a product from search results
    search-results.Click Product link
    product.Verify Page Loaded

user selects a searched product
    [Documentation]  This 2nd level keyword calls other 1st level keywords to help simplify the test case
    user searches for products
    search results contains relevant products
    user selects a product from search results

correct product page loads
    product.Verify Page Loaded

user adds that product to their cart
    product.Add to Cart

user adds a product to their cart
    [Documentation]  This 2nd level keyword calls other 1st level keywords to help simplify the test case
    user searches for products
    search results contains relevant products
    user selects a product from search results
    correct product page loads
    user adds that product to their cart
    the product is present in cart

the product is present in cart
    cart.Verify Product Added

user attempts to checkout
    cart.Proceed to Checkout

the user is required to sign in
    sign-in.Verify Page Loaded
