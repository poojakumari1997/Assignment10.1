

*** Settings ***
Library  SeleniumLibrary
#Library    ExtendedSelenium2Library



*** Variables ***
${browser}    gc
${url}    https://www.bookswagon.com/
${bookcategory}    xpath=//div[@class='books-category']/ul/li[15]
${submenu}    xpath=//div[@class='bc-menu']/ul/li[12]
${submenu1}    xpath=//div[@class='bc-menu']/ul/li[12]
${text-book}    Lifestyle    
${menu}    Sports
${subtext}    Motor sports
${element_count}    xpath= //div[@id='listSearchResult']/div
${scrollele}    Total Competition

*** Keywords ***
User is allowed to Open Book Search
    Open Browser    ${url}   ${browser}
    Maximize Browser Window

Search for Lifestyle Book
    Wait Until Page Contains    ${text-book}    timeout=20s
    Click Element    ${bookcategory}

Search for Sports category
     Wait Until Page Contains    ${menu}    timeout=100s
     Click Element    ${submenu}

Search for Motor Sports
    Wait Until Page Contains    ${subtext}    timeout=100s
    Click Element    ${submenu1}

Click a book from motor sports 
    ${cnt}   Get Element Count    ${element_count}
    Log to console    ${cnt}

    FOR    ${j}    IN RANGE    1    ${cnt}
        ${Book_text}    Get Text    xpath=//div[@id='listSearchResult']/div[${j}]/div[3]/div[1]/a
        Log To Console    ${Book_text}
        Scroll Element Into View    xpath=//div[@id='listSearchResult']/div[${j}]/div[3]/div[1]/a
        Exit For Loop If  "${Book_text}" == "${scrollele}"
    END
    Set Suite Variable    ${selectedbook}    xpath=//div[@id='listSearchResult']/div[${j}]/div[3]/div[1]/a
    Click Element    ${selectedbook}
    Close Browser    


    

#Robot -d report -i demo  Demo.robot
*** Test Cases ***
Verify Books selected from Menu
    [Tags]  demo
    User is allowed to Open Book Search
    Search for Lifestyle Book
    Search for Sports category
    Search for Motor Sports
    Click a book from motor sports 
    

