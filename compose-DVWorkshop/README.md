Data Virtualization Financials Workshop Environment
=======
(!! This project is still in progress)

 This environment is designed for [JDV Financials WOrkshop](https://github.com/DataVirtualizationByExample/DVWorkshop). Environment
 consist a single JDV container and a Postgres 9.3 container


## How to run

   If everything is properly installed, the following command should be enough

```bash
  sh runDemo.sh
```
   If you have docker-compose installed on your system, you can alternatively start the demo containers with docker-compose:

```bash
  sh runComposer.sh
```

   POstgres server is exposed through port 5432, ```postgres``` user can be used to access it with ```postgres``` password.

  To stop and destroy demo containers:
```bash
sh destroyDemo.sh
```
 
