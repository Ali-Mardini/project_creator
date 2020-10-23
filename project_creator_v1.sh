#!/bin/bash 
###################################################################
#Script Name	: Project Creator                                                                                     
#Description	: This script will create dotnet core project with onion architecture                                                                                                                                                                    
#Author       	: Ali Mardini                                             
#Email         	: mardinia6@gmail.com                                           
###################################################################

# read the project name 
echo Please enter the project name:
read project_name

# if the project name is not null or empty
if [[ $project_name != "" ]]; then 

    # Create Empty solution
    echo creating $project_name solution ........
    dotnet new sln -n $project_name

    #Create project folder
    echo creating Domain folder ........
    mkdir Domain

    echo creating Infrastructure folder ......
    mkdir Infrastructure

    echo creating Interfaces folder .........
    mkdir Interfaces

    echo creating Services folder ..........
    mkdir Services

    echo creating API folder ........
    mkdir API

    echo creating FunctionalTests folder .......
    mkdir FunctionalTests

    echo creating UnitTests folder ........
    mkdir UnitTests

    # Create domain project 
    echo creating $project_name Domain .........
    dotnet new classlib -n $project_name.domain -o Domain/$project_name.domain

    echo adding $project_name.domain to solution ........
    dotnet sln add Domain/$project_name.domain/$project_name.domain.csproj

    #Create Infrastructure project
    echo creating $project_name Infrastructure .........
    dotnet new classlib -n $project_name.infrastructure -o Infrastructure/$project_name.infrastructure

    echo adding $project_name.infrastructure to solution ........
    dotnet sln add Infrastructure/$project_name.infrastructure/$project_name.infrastructure.csproj

    #Create Interfaces project
    echo creating $project_name Interfaces .........
    dotnet new classlib -n $project_name.interfaces -o Interfaces/$project_name.interfaces

    echo adding $project_name.interfaces to solution ........
    dotnet sln add Interfaces/$project_name.interfaces/$project_name.interfaces.csproj

    #Create Services project
    echo creating $project_name Services .........
    dotnet new classlib -n $project_name.services -o Services/$project_name.services

    echo adding $project_name.services to solution ........
    dotnet sln add Services/$project_name.services/$project_name.services.csproj

    #Create API project
    echo "please select the number of the api project you want: "

    echo "[1] Api Project"
    echo "[2] Identity Server"
    read api_project

    if [[ "$api_project" = "1" ]]
        then
            echo creating $project_name API .........
            dotnet new webapi -n $project_name.api -o API/$project_name.api
            echo adding $project_name.api to solution ........
            dotnet sln add API/$project_name.api/$project_name.api.csproj

            # add files to .gitignore
            echo "writing in .gitignore file ......"
            printf '%s\n' '#API' \
            'API/'$project_name'.api/bin' \
            'API/'$project_name'.api/obj' >> .gitignore

    elif [[ "$api_project" = "2" ]]
        then
            echo creating $project_name Identity Server .........
            dotnet new is4ef -n $project_name.api -o API/$project_name.api
            echo adding $project_name.api to solution ........
            dotnet sln add API/$project_name.api/$project_name.api.csproj

            # add files to .gitignore
            echo "writing in .gitignore file ......"
            printf '%s\n' '#API' \
            'API/'$project_name'.api/bin' \
            'API/'$project_name'.api/obj' >> .gitignore
    fi

    
    #Create FunctionalTests project
    echo creating $project_name FunctionalTests .........
    dotnet new xunit -n $project_name.functional-tests -o FunctionalTests/$project_name.functional-tests

    echo adding $project_name.functional-tests to solution ........
    dotnet sln add FunctionalTests/$project_name.functional-tests/$project_name.functional-tests.csproj


    #Create UnitTests project
    echo creating $project_name UnitTests .........
    dotnet new xunit -n $project_name.unit-tests -o UnitTests/$project_name.unit-tests

    echo adding $project_name.unit-tests to solution ........
    dotnet sln add UnitTests/$project_name.unit-tests/$project_name.unit-tests.csproj

    #Create .gitignore file 
    echo creating .gitignore file ..........
    touch .gitignore
    echo "writing in .gitignore file ......"
    printf '%s\n' '#.Vs & .Vscode'\
    '.vs' \
    '.vscode' \
    '#Domain' \
    'Domain/'$project_name'.domain/bin' \
    'Domain/'$project_name'.domain/obj' \
    '#Infrastructure' \
    'Infrastructure/'$project_name'.infrastructure/bin' \
    'Infrastructure/'$project_name'.infrastructure/obj' \
    '#Interfaces' \
    'Interfaces/'$project_name'.interfaces/bin' \
    'Interfaces/'$project_name'.interfaces/obj' \
    '#Services' \
    'Services/'$project_name'.services/bin' \
    'Services/'$project_name'.services/obj' \
    '#FunctionalTests' \
    'FunctionalTests/'$project_name'.functional-tests/bin' \
    'FunctionalTests/'$project_name'.functional-tests/obj' \
    '#UnitTests' \
    'UnitTests/'$project_name'.unit-tests/bin' \
    'UnitTests/'$project_name'.unit-tests/obj' > .gitignore

     #Create UI project if needed
    echo "do you need any UI project (y/n)?"
    read ui_needed

    if [[ "$ui_needed" = "y" ]]
    then 
        echo "Creating UI folder ......."
        mkdir UI
        echo "please select the number of one of the following UI project :"
        echo "[1] web mvc project"
        echo "[2] Angular project"
        echo "[3] React Js project"
        read ui_project
        if [[ "$ui_project" = "1" ]]
        then
            echo "Creating the web mvc project"
            dotnet new mvc -n $project_name.ui -o UI/$project_name.ui
            echo adding $project_name.ui to solution ........
            dotnet sln add UI/$project_name.ui/$project_name.ui.csproj

            # add files to .gitignore
            echo "writing in .gitignore file ......"
            printf '%s\n' '#UI' \
            'UI/'$project_name'.ui/bin' \
            'UI/'$project_name'.ui/obj' >> .gitignore

        elif [[ "$ui_project" = "2" ]]
        then
            echo "Creating Angular project"
            cd UI
            ng new $project_name
        elif [[ "$ui_project" = "3" ]]
        then
            echo "Creating React Js project"
            cd UI
            echo "please enter react js project name and make sure its lower case e.g(my-react-app):"
            read react_project_name
            npx create-react-app $react_project_name
        else
            echo "No project found. Invalid option, please create your UI manualy"
        fi
    fi

fi