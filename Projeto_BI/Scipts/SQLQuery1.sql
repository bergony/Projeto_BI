USE ImdbStage;

WITH Calendar AS (
    SELECT DATEFROMPARTS(1894, 1, 1) AS Data -- Define a data inicial
    UNION ALL
    SELECT DATEADD(DAY, 1, Data)
    FROM Calendar
    WHERE Data < DATEFROMPARTS(2022, 12, 31) -- Define a data final
)
SELECT
    Data
    , FORMAT(data, 'dd/MM/yyyy', 'pt-BR') AS DataPt_BR
    , YEAR(Data) AS Ano
    , RIGHT(YEAR(Data), 2) AS Anoabrev
    , MONTH(Data) AS Mes
    , DAY(Data) AS Dia
    , UPPER(LEFT(FORMAT(data, 'MMMM', 'pt-BR'), 1)) + lower(SUBSTRING(FORMAT(data, 'MMMM', 'pt-BR'),2,LEN(FORMAT(data, 'MMMM', 'pt-BR'))))  AS NomeMes -- maiusculo mes
    , UPPER(LEFT(FORMAT(data, 'MMMM', 'pt-BR'), 1)) + LOWER(SUBSTRING(FORMAT(data, 'MMMM', 'pt-BR'), 2, LEN(FORMAT(data, 'MMMM', 'pt-BR')))) AS Mesabrev -- maiusculo mes
    , UPPER(LEFT(FORMAT(data, 'dddd', 'pt-BR'), 1)) + LOWER(SUBSTRING(FORMAT(data, 'dddd', 'pt-BR'), 2, LEN(FORMAT(data, 'dddd', 'pt-BR')))) AS NomeDia -- maiusculo mes
    , UPPER(LEFT(FORMAT(data, 'ddd', 'pt-BR'), 1)) + LOWER(SUBSTRING(FORMAT(data, 'ddd', 'pt-BR'), 2, LEN(FORMAT(data, 'ddd', 'pt-BR')))) AS Diabrev 
    , DATEPART(dw, Data) AS NumeroDiaDaSemana
    , DATEPART(week, Data) AS SemanaDoAno
    , DATEPART(quarter, Data) AS Trimestre
INTO [dbo].[DCalendario]
FROM Calendar
OPTION (MAXRECURSION 0); -- Necessario para evitar erros de limite de recursao


------ DimGenre Create
SELECT distinct genre
FROM [ImdbStage].[dbo].[MovieStage]

ALTER TABLE [dbo].[DimGenre]
ALTER COLUMN genre nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[DimGenre]
ADD PRIMARY KEY (genre);

------- DimCountry Create
SELECT distinct
      country
FROM [ImdbStage].[dbo].[MovieStage] where country is not null

ALTER TABLE [dbo].[DimCountry]
ALTER COLUMN country nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[DimCountry]
ADD PRIMARY KEY (country);

------- DimCountry director
SELECT distinct director
FROM [ImdbStage].[dbo].[MovieStage] where director is null;

ALTER TABLE [dbo].[DimDirector]
ALTER COLUMN director nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[DimDirector]
ADD PRIMARY KEY (director);
------- DimCountry Calendario
select REPLACE (data, '-', '') as date_id,
* from [dbo].[DCalendario];

ALTER TABLE [dbo].[DimCalendario]
ALTER COLUMN date_id nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[FatoMovie]
ALTER COLUMN date_id nvarchar(255);

ALTER TABLE [dbo].[DimCalendario]
ADD PRIMARY KEY (date_id);

------- DimCountry Calendario

ALTER TABLE [dbo].[DimMovie]
ALTER COLUMN imdb_title_id nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[DimMovie]
ADD PRIMARY KEY (imdb_title_id);

use [ImdbStage]

select
LEFT(SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000),
           PATINDEX('%[^0-9.-]%', SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000) + 'X') -1) as imdb_title_id,
date_published,
REPLACE (date_published, '-', '') as date_id,
genre,
country,
director,
avg_vote, 
votes, 
reviews_from_critics, 
reviews_from_users		 
from [dbo].[MovieStage] 
where country is not null and director is not null and len(date_published) = 10;

truncate table [dbo].[DimGenre]
truncate table [dbo].[DimCountry]
truncate table [dbo].[DimDirector]
truncate table [dbo].[DimCalendario]
truncate table [dbo].[FatoMovie]

use [ImdbDW]

ALTER TABLE [dbo].[FatoMovie]
ALTER COLUMN imdb_title_id nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[FatoMovie]
ADD PRIMARY KEY (imdb_title_id);

ALTER TABLE [dbo].[FatoMovie]
ADD FOREIGN KEY (genre) REFERENCES [dbo].[DimGenre](genre);

ALTER TABLE [dbo].[FatoMovie]
ADD FOREIGN KEY (country) REFERENCES [dbo].[DimCountry](country);

ALTER TABLE [dbo].[FatoMovie]
ADD FOREIGN KEY (director) REFERENCES [dbo].[DimDirector](director);

ALTER TABLE [dbo].[FatoMovie]
ADD FOREIGN KEY (date_id) REFERENCES [dbo].[DimCalendario](date_id);

ALTER TABLE [dbo].[FatoMovie]
ADD FOREIGN KEY (imdb_title_id) REFERENCES [dbo].[DimMovie](imdb_title_id);

use [ImdbDW]

select
LEFT(SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000),
           PATINDEX('%[^0-9.-]%', SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000) + 'X') -1) as imdb_title_id,
title
from [dbo].[MovieStage] 
where country is not null and director is not null and len(date_published) = 10;

select * from [dbo].[RatingStage];

SELECT LEFT(SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000),
           PATINDEX('%[^0-9.-]%', SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000) + 'X') -1) as imdb_title_id,
	LEFT(SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000),
           PATINDEX('%[^0-9.-]%', SUBSTRING(imdb_title_id, PATINDEX('%[0-9.-]%', imdb_title_id), 8000) + 'X') -1) as movie_id
      ,[weighted_average_vote]
      ,[total_votes]
      ,[mean_vote]
      ,[median_vote]
      ,[votes_10]
      ,[votes_9]
      ,[votes_8]
      ,[votes_7]
      ,[votes_6]
      ,[votes_5]
      ,[votes_4]
      ,[votes_3]
      ,[votes_2]
      ,[votes_1]
  FROM [ImdbStage].[dbo].[RatingStage];


  
ALTER TABLE [dbo].[FatoRating]
ALTER COLUMN imdb_title_id nvarchar(255) NOT NULL;

ALTER TABLE [dbo].[FatoRating]
ADD PRIMARY KEY (imdb_title_id);

ALTER TABLE  [dbo].[FatoRating]
ADD FOREIGN KEY (movie_id) REFERENCES [dbo].[DimMovie](imdb_title_id);





