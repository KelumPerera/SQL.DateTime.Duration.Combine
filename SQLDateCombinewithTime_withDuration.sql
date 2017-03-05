DROP TABLE IF EXISTS [test].[dbo].[test]  -- From SQL Server 2016 you can use


IF OBJECT_ID('[test].[dbo].[test]') IS NOT NULL   -- From any SQL Server version you can use
    DROP TABLE [test].[dbo].[test]


create table [test].[dbo].[test](
    MyDate datetime NULL,
    MyTime datetime NULL,
    MyDuration INT NULL)

-- Insert some data
insert [test].[dbo].[test] (MyDate, MyTime, MyDuration)
values ('2017-03-05 00:00:00.000', '1899-12-30 15:26:19.000', 151),
       ('2017-03-05 00:00:00.000', '1899-12-30 05:51:38.000', 1400)
       
select * from [test].[dbo].[test]

-- 1. combine the date from [MyDate] with the time from [MyTime] as [MyNewStartDateTime]
-- 2. Add the [MyDuration] in seconds with the above created [MyNewStartDateTime] as to create the [MyEndDateTime]
-- 3. Put all columns into a new table
SELECT *
	,convert(datetime, [MyDate]) + convert(datetime, (convert( char(8), [MyTime], 108))) AS [MyNewStartDateTime]
	,dateadd(second, [MyDuration], (convert(datetime, [MyDate]) + convert(datetime, (convert( char(8), [MyTime], 108))))) AS [MyEndDateTime]
INTO [test].[dbo].[test1]
from [test].[dbo].[test];