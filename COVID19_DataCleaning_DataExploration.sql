use Covid19_Analysis;


select * from CovidDeaths;
select * from CovidVaccinations;

-- 1. DATA CLEANING --

--Changing the Date format to only Date

Alter table CovidDeaths
Alter column date Date;

alter table CovidVaccinations
alter column date Date;

select * from CovidDeaths;
select * from CovidVaccinations;

-- Removing Inconistency in data --
-- Removing the rows where continent is null --

select * from CovidDeaths where continent is Null;
select * from CovidVaccinations where continent is Null;

delete from CovidDeaths where iso_code like '%OWID%';
delete from CovidVaccinations where iso_code like '%OWID%';

select * from CovidDeaths where continent is Null;
select * from CovidVaccinations where continent is Null;

-- Part 2: Data Exploration --

-- Infection Rate --

select location, population, max(total_cases) as HighestCases, max((total_cases/population)*100) as Infected_Percentage
from CovidDeaths
group by location, population
order by Infected_Percentage desc; --Highest: Andorra, 17.12% --Total Cases = 13,232

select Top 1 location, date, population, total_cases, (total_cases/population)*100 as Infected_Percentage
from CovidDeaths
where location = 'india'
order by (total_cases/population)*100 desc; --Highest= 1.39% --Total Cases = 1,91,64,969

select Top 1 location, date,population, total_cases, (total_cases/population)*100 as Infected_Percentage
from CovidDeaths
where location like '%states%'
order by (total_cases/population)*100 desc; --Highest = 9.77% --Total Cases = 3,23,46,971

select Top 1 location, date,population, total_cases, (total_cases/population)*100 as Infected_Percentage
from CovidDeaths
where location = 'nepal'
order by (total_cases/population)*100 desc; --Highest= 1.11% --Total Cases = 3,23,187

-- Percentage Of Death --

select SUM(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_death, (sum(cast(new_deaths as int))/SUM(new_cases))*100 as DeathPercentage
from CovidDeaths; --Global Data

select continent ,SUM(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_death
from CovidDeaths
group by continent; --Global Data

select top 10 location, max(total_cases) as HighestCases, max((total_cases/population)*100) as Infected_Percentage, max(cast(total_deaths as int)) as TotalNumberOfDeaths, (max(cast(total_deaths as int))/max(total_cases))*100 as DeathPercentage
from Covid_Data_Analysis..CovidDeaths
where continent is not null
group by location
order by TotalNumberOfDeaths desc
--Highest: USA, 5,76,232 , 1.78140%;

--4th Highest: India, 211853 , 1.10541%;

select continent, max(total_cases) as HighestCases, max(cast(total_deaths as int)) as TotalNumberOfDeaths
from CovidDeaths
group by continent
order by HighestCases desc;
--Highest Deaths: North America
--Highest Cases: North America

-- Joining Two Tables --
-- Population vs Vaccinations --
select cd.continent, cd.location, cd.date, population,
sum(convert(int, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date)
as TotalNumberOfVaccinations
from CovidDeaths cd
join CovidVaccinations cv 
on cd.location = cv.location and cd.date = cv.date

-- Percent of population vaccinated --

select location as Country, max(population) as Population, sum(new_cases) as TotalCases
from CovidDeaths
group by location
order by 3 desc;

with PopulationVsVaccinated (location, date, population, TotalNumberOfVaccinations)
as
(
select cd.location, cd.date, cd.population,
sum(convert(int, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as TotalNumberOfVaccinations
from CovidDeaths cd
join CovidVaccinations cv 
on cd.location = cv.location and cd.date = cv.date
where cd.location = 'india'
)
select *, 
(TotalNumberOfVaccinations/population)*100 as PercentageOfVaccinatedPeople 
from PopulationVsVaccinated
order by 5 desc;

select cd.location, cd.date, cd.population,
sum(convert(int,cd.new_cases)) over (partition by cd.location order by cd.location, cd.date) as TotalNumberOfCases,
sum(convert(int,cd.new_deaths)) over (partition by cd.location order by cd.location, cd.date) as TotalNumberOfDeaths,
sum(convert(int, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as TotalNumberOfVaccinations
from CovidDeaths cd
join CovidVaccinations cv 
on cd.location = cv.location and cd.date = cv.date
where cd.location = 'india';


