FROM microsoft/dotnet:sdk as buildenv
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=buildenv /app/out .
ENTRYPOINT ["dotnet", "WebApp.dll"]
