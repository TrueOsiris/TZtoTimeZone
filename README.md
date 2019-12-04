# TZtoTimeZone
TZ unix TimeZones to MS SQL Server 2016 compliant Timezone names.

Input is the column on the left.
The TimeZone column can be used with the AT TIME ZONE function :
https://docs.microsoft.com/en-us/sql/t-sql/queries/at-time-zone-transact-sql?view=sql-server-ver15


| TZ | TimeZone	| current_utc_offset | is_currently_dst |
| ------------------------ | ------------------------------------ | --------------------------- | ------------------- |
| NULL |                   UTC	|                                   +00:00	 |             0 |
| AFRICA/ADDIS_ABABA |	   E. Africa Standard Time	 |              +03:00	 |             0 |
| AFRICA/ALGIERS	|        Central European Standard Time	|         +01:00	   |           0 |
| AFRICA/BRAZZAVILLE	|    W. Central Africa Standard Time	|       +01:00	  |            0 |
| AFRICA/LAGOS	 |         W. Central Africa Standard Time	|       +01:00	  |            0 |
| AFRICA/LUANDA	 |         W. Central Africa Standard Time	|       +01:00	  |            0 |
| AFRICA/NAIROBI	|        E. Africa Standard Time	  |             +03:00	  |            0 |
| AFRICA/TUNIS	|          Central European Standard Time	 |        +01:00	   |           0 |
| AFRICA/WINDHOEK	|        Namibia Standard Time	|                 +02:00	|              0 |
| AMERICA/ANCHORAGE	|      Alaskan Standard Time	 |                -09:00	 |             0 |
| AMERICA/ASUNCION |	     Paraguay Standard Time |	                -03:00 |               1 |

