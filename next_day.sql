USE [Monitor]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[next_day] (@source_date date, @day_of_week nvarchar(9)) returns date as
begin
	--TSQL implementation of Oracle's function
	--https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions093.htm
	--Except here you need only supply the first two letters of the week day—perhaps that is buggy?  I don't care.
	declare @i_day_of_week int;	select @i_day_of_week = case lower(left(@day_of_week,2)) when 'su' then 1 when 'mo' then 2 when 'tu' then 3 when 'we' then 4 when 'th' then 5 when 'fr' then 6 when 'sa' then 7 end;
	if (@i_day_of_week is null) return cast(N'Invalid weekday argument supplied' as date);
	declare @i_source_date_day_of_week int;	select @i_source_date_day_of_week = datepart(weekday,@source_date);
	declare @interval int;
	select @interval = case 
		when @i_source_date_day_of_week < @i_day_of_week then @i_day_of_week - @i_source_date_day_of_week
		else @i_day_of_week +7 - @i_source_date_day_of_week end;
	--select @interval =(@i_day_of_week +7 - @i_source_date_day_of_week)%7;
	return dateadd(dd,@interval,convert(date,@source_date));
end
--	select dbo.next_day (dateadd(dd,-7,convert(date,getdate())),'Friday');
;
GO
