*** Settings ***
Suite Setup       Start Web Test
Suite Teardown       End Web Test



Resource          ../Resources/Common.robot
Library           ../Libraries/test_lib.py
Library    Collections
Library    String

*** Variables ***
${SearchString}    west kingdom
# ${SearchString}    architects of the west kingdom



*** Test Cases ***
ts1
    [Documentation]    Check search results for pre-defines string
    Search For String    ${SearchString}
    Check Search Results
    Open Random Page
    Check Text On Page
    Capture Screenshots

*** Keywords ***


