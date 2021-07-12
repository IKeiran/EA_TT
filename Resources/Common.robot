*** Settings ***
Library           SeleniumLibrary
Library           ./Locators.robot



*** Variables ***
${BaseUrl}    https://www.google.com/
${Browser}    chrome
${SearchResult_xpath}    //div[@class='g']//em/..
${SearchResult_links_xpath}    //div[@class="g"]//a
${PageBody_xpath}    //body
${ElementsWithSearchText}    //p[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'${SearchString}')]


*** Keywords ***
Search For String
    [Documentation]    Search for the pre0defined string
    [Arguments]    ${SearchString}
    Input Text    name=q    ${SearchString}
    Press Keys    name=q    ENTER


Check Search Results
    [Documentation]    Check that all search results contains searching text
    @{locators}=     Get Webelements    ${SearchResult_xpath}
    ${result}=       Create List
    ${SearchWords}=     Split String     ${SearchString}
    FOR   ${locator}   IN    @{locators}
          ${text}=     Get Text    ${locator}
          ${income}=    Check Substring    ${text}    ${SearchString}
         Should Be True    ${income}
    END


Check Text On Page
    [Documentation]    Check that page contains searching text
    ${text}=           Get Text  ${PageBody_xpath}
    ${SearchWords}=    Split String     ${SearchString}
    ${income}=         Check Substring    ${text}    ${SearchString}
    Should Be True     ${income}


Open Random Page
    [Documentation]    Open Random Page to check search results

    @{locators}=     Get Webelements    ${SearchResult_links_xpath}
    ${max_count}=    Get Element Count    ${SearchResult_links_xpath}
    ${value}=        Evaluate  random.choice(range(${max_count}))  random
    Log To Console    ${value}
    Wait Until Element Is Visible     ${locators}[${value}]
    Click Link       ${locators}[${value}]
    BuiltIn.Sleep    5


Start Web Test
    [Documentation]    Prepare environment for the tests
    Open Browser       ${BaseUrl}    ${Browser}
    Maximize Browser Window


End Web Test
    [Documentation]    TearDown the environment
    BuiltIn.Sleep     5
    Close Browser


Capture Screenshots
    [Documentation]    make screenshots of elements that contains search text
    ${xpath}=    Set Variable    ${ElementsWithSearchText}


    @{locators}=     Get Webelements    ${xpath}
    ${max_count}=     Get Element Count    ${xpath}
    Log To Console    ${max_count}

    ${result}=       Create List
    ${counter}=    Set Variable    0
    Log To Console    -------------------------
    FOR   ${counter}   IN RANGE    ${max_count}
           Log To Console    New ScreenShot Should be created
           Log To Console    ${locators}[${counter}]
           Log To Console    ${counter}

           ${check_element}=  Run Keyword and Return Status   Wait Until Element Is Visible    ${locators}[${counter}]    2s
           Run Keyword If      '${check_element}' == 'True'     Capture Element Screenshot      ${locators}[${counter}]

           ${counter}=    Increment Variable    ${counter}

    END