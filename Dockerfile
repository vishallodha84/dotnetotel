FROM mcr.microsoft.com/dotnet/sdk:5.0

# RUN addgroup -g 1000 app &&  adduser -u 1000 -h /app -G app -S app
# RUN  bash -c "dotnet restore && dotnet build && dotnet run  --urls http://+:5000"

WORKDIR /app
USER app

COPY ./app .

CMD ["./app"] 