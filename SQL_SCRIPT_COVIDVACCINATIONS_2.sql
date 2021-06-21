---Data Wrangling on Covid Vaccinations Data
--Joining the two tables on date and location since these are more specific

Select * from 
Covid19DataInsights..CovidDeaths d
join Covid19DataInsights..CovidVaccinations v
on d.location=v.location
and d.date=v.date

----Scenario 1: Total population and people vaccinated each day
Select d.location, d.continent, d.date, d.population, v.new_vaccinations from 
Covid19DataInsights..CovidDeaths d
join Covid19DataInsights..CovidVaccinations v
on d.location=v.location
and d.date=v.date
where d.continent is not null
order by d.location, d.date


----Scenario 2: Percentage of people Vaccinated So far as per Location
With TempTable(location, continent,date,population, new_vaccinations, TotalPeopleVaccinated)
as
(
Select d.location, d.continent, d.date, d.population, v.new_vaccinations ,
Sum(Convert(int,v.new_vaccinations)) Over (Partition by d.Location order by d.Location, d.date) as TotalPeopleVaccinated
from Covid19DataInsights..CovidDeaths d
join Covid19DataInsights..CovidVaccinations v
on d.location=v.location
and d.date=v.date
where d.continent is not null
)
Select *, (TotalPeopleVaccinated/population)*100 as Percentage_People_vaccinated
from TempTable;