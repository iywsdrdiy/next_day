# next_day
TSQL implementation of [Oracle's next_day function](https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions093.htm).

Here you need only supply the first two letters of the week day, and it only uses English week day names.

To get the most recent Friday's date:
```
select dbo.next_day (dateadd(dd,-7,convert(date,getdate())),'Friday');
```
I don't know why Microsoft doesn't provide this function as standard.  Unfortunately the Microsoft date manipulation is a lot more verbose than Oracle's too: `select next_day(sysdate-7,'Friday') from dual` is a lot easier to read.
