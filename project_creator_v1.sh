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
    dotnet new classlib -n $project_name.Domain -o Domain/$project_name.Domain

    echo adding $project_name.Domain to solution ........
    dotnet sln add Domain/$project_name.Domain/$project_name.Domain.csproj

    #Create Infrastructure project
    echo creating $project_name Infrastructure .........
    dotnet new classlib -n $project_name.Infrastructure -o Infrastructure/$project_name.Infrastructure

    echo adding $project_name.Infrastructure to solution ........
    dotnet sln add Infrastructure/$project_name.Infrastructure/$project_name.Infrastructure.csproj

    #Create Interfaces project
    echo creating $project_name Interfaces .........
    dotnet new classlib -n $project_name.Interfaces -o Interfaces/$project_name.Interfaces

    echo adding $project_name.Interfaces to solution ........
    dotnet sln add Interfaces/$project_name.Interfaces/$project_name.Interfaces.csproj

    #Create Services project
    echo creating $project_name Services .........
    dotnet new classlib -n $project_name.Services -o Services/$project_name.Services

    echo adding $project_name.Services to solution ........
    dotnet sln add Services/$project_name.Services/$project_name.Services.csproj

    #Create API project
    echo creating $project_name API .........
    dotnet new webapi -n $project_name.API -o API/$project_name.API

    echo adding $project_name.API to solution ........
    dotnet sln add API/$project_name.API/$project_name.API.csproj

    #Create FunctionalTests project
    echo creating $project_name FunctionalTests .........
    dotnet new xunit -n $project_name.FunctionalTests -o FunctionalTests/$project_name.FunctionalTests

    echo adding $project_name.FunctionalTests to solution ........
    dotnet sln add FunctionalTests/$project_name.FunctionalTests/$project_name.FunctionalTests.csproj


    #Create UnitTests project
    echo creating $project_name UnitTests .........
    dotnet new xunit -n $project_name.UnitTests -o UnitTests/$project_name.UnitTests

    echo adding $project_name.UnitTests to solution ........
    dotnet sln add UnitTests/$project_name.UnitTests/$project_name.UnitTests.csproj

    #Create .gitignore file 
    echo creating .gitignore file ..........
    touch .gitignore
    echo "writing in .gitignore file ......"
    printf '%s\n' '#.Vs & .Vscode'\
    '.vs' \
    '.vscode' \
    '#API' \
    'API/'$project_name'.API/bin' \
    'API/'$project_name'.API/obj' \
    '#Domain' \
    'Domain/'$project_name'.Domain/bin' \
    'Domain/'$project_name'.Domain/obj' \
    '#Infrastructure' \
    'Infrastructure/'$project_name'.Infrastructure/bin' \
    'Infrastructure/'$project_name'.Infrastructure/obj' \
    '#Interfaces' \
    'Interfaces/'$project_name'.Interfaces/bin' \
    'Interfaces/'$project_name'.Interfaces/obj' \
    '#Services' \
    'Services/'$project_name'.Services/bin' \
    'Services/'$project_name'.Services/obj' \
    '#FunctionalTests' \
    'FunctionalTests/'$project_name'.FunctionalTests/bin' \
    'FunctionalTests/'$project_name'.FunctionalTests/obj' \
    '#UnitTests' \
    'UnitTests/'$project_name'.UnitTests/bin' \
    'UnitTests/'$project_name'.UnitTests/obj' > .gitignore

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
            dotnet new mvc -n $project_name.UI -o UI/$project_name.UI
            echo adding $project_name.UI to solution ........
            dotnet sln add UI/$project_name.UI/$project_name.UI.csproj

            # add files to .gitignore
            echo "writing in .gitignore file ......"
            printf '%s\n' '#UI' \
            'UI/'$project_name'.UI/bin' \
            'UI/'$project_name'.UI/obj' >> .gitignore

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