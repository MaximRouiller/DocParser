docker build . -t docparser:latest

$date = "2019-11-01"

# dotnet
docker run --rm -it -e DATE=$date -e SIGNIFICANT_CHANGE=25 -e REPOSITORY=https://github.com/dotnet/docs -v c:/git_ws/MaximRouiller/DocParser/output:/data docparser:latest

# nuget
docker run --rm -it -e DATE=$date -e SIGNIFICANT_CHANGE=15 -e PRODUCT=nuget -e BASE_URL=https://docs.microsoft.com/nuget/ -e REPOSITORY=https://github.com/NuGet/docs.microsoft.com-nuget -v c:/git_ws/MaximRouiller/DocParser/output:/data docparser:latest

# asp.net
docker run --rm -it -e DATE=$date -e ROOT_FOLDER=aspnetcore -e SIGNIFICANT_CHANGE=25 -e PRODUCT=aspnet -e BASE_URL=https://docs.microsoft.com/aspnet/core/ -e REPOSITORY=https://github.com/aspnet/AspNetCore.Docs -v c:/git_ws/MaximRouiller/DocParser/output:/data docparser:latest

# entity framework
docker run --rm -it -e DATE=$date -e ROOT_FOLDER="entity-framework" -e SIGNIFICANT_CHANGE=15 -e PRODUCT=entityframework -e BASE_URL=https://docs.microsoft.com/ef/ -e REPOSITORY=https://github.com/aspnet/EntityFramework.Docs -v c:/git_ws/MaximRouiller/DocParser/output:/data docparser:latest