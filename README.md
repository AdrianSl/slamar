#SLAMAR

This app is being developed for specific company. Its main purpouse is to record all types of cashflow in that company. 

For now, app consists of 2 main cashflow models:
- income - they are assocciated with 3 sources of income: Brand Shops, External Shops and Truck Routes. Incomes that derive from Truck Routes are also assocciated with Driver.
- genereal expense - they are assocciated with User model

App features:
- site is closed for unlogged users
- users (emloyees of the company) log in with email
- dashboard - daily overview of all incomes and expenses
- creation of new workday - it creates expected incomes with empty values
- view/add/edit/delete Incomes/Expenses
- view/add/edit BrandShops/ExternalShops/TruckRoutes/Drivers
- BrandShops/ExternalShops/TruckRoutes/Drivers can be deleted if they do not have assocciation to Incomes

Planned features:
- Analysis and Charts of Incomes/Expenses
