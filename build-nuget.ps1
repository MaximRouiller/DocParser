docker build . -t docparser:latest
docker run --rm -it -e DATE="2019-08-01" -e SIGNIFICANT_CHANGE=15 -e PRODUCT=nuget -e BASE_URL=https://docs.microsoft.com/nuget/ -e REPOSITORY=https://github.com/NuGet/docs.microsoft.com-nuget -v c:/git_ws/MaximRouiller/DocParser/output:/data docparser:latest