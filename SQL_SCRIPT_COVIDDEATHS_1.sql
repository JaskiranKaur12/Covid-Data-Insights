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
