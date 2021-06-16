Select * from Covid19DataInsights..CovidDeaths
order by 3,4

Select * from Covid19DataInsights..CovidVaccinations

--Basic Data suct as TotalCases, NewCases, TotalDeaths and population based on country and date
Select location, date,population, total_cases, new_cases, total_deaths
from CovidDeaths


--Scenario 1: Total Deaths against Total Cases for each country and finding death percentage
--Your Probability of dying if you come in contact with an infected person in your country

Select location, date, total_cases, (total_deaths/total_cases)*100 as [Death Percentage]
from CovidDeaths
where location LIKE 'India'

--Scenario 2: Total Cases Vs Population of each country
--Percentage of population infected everyday in your country
Select location, date, population, total_cases, (total_cases/population)*100 as [Infected Population]
from CovidDeaths
where location LIKE 'India'

--Scenario 3: Highest Cases in each country
Select location, population, max(total_cases) as HighestInfectionSoFar, (max(total_cases)/population)*100 as [Infected Population]
from CovidDeaths
group by location, population
order by [Infected Population] desc

--Scenario 4: Countries with Highest Death Rates
--Total_Deaths data type was nvarchar, so used the cast function
--earlier it was giving the max_deaths odf continnet as well, so figured out that where continent field is null means it is an entire continent
Select location, Max(Cast(Total_deaths as int)) as MaximumDeaths, Round(Max((Total_deaths/Total_cases)*100), 3)  as Max_Death_Percentage
from CovidDeaths
where continent is not null
group by location
order by MaximumDeaths desc;


---Scenario 5: Coontinents with highest death rate
Select continent, Max(Cast(Total_deaths as int)) as MaximumDeaths
from CovidDeaths
where continent is not null
group by continent
order by MaximumDeaths desc;


--Scenario 6: Total new cases, Total new deaths on each day 
Select date, Sum(new_cases) as Total_Cases, Sum(Cast(new_deaths as int)) as TotalDeaths, (Sum(Cast(new_deaths as int))/Sum(new_cases))*100 as Death_Percentage
from CovidDeaths
where continent is not null
group by date
order by date;

--Scenario 7: Total cases and deaths so far all over the world
Select Sum(new_cases) as Total_Cases, Sum(Cast(new_deaths as int)) as TotalDeaths, (Sum(Cast(new_deaths as int))/Sum(new_cases))*100 as Death_Percentage
from CovidDeaths
where continent is not null;


