IF OBJECT_ID('dbo.TZtoTimeZone') IS NOT NULL
	DROP FUNCTION dbo.TZtoTimeZone;
GO

CREATE FUNCTION [dbo].[TZtoTimeZone](@TZ AS VARCHAR(50))  
/* timezone sources:
	https://www.zeitverschiebung.net/en/country/co
	https://timezonedb.com/time-zones
	https://support.microsoft.com/en-us/help/973627/microsoft-time-zone-index-values
	https://www.timeanddate.com/worldclock
	Time & effort done by Tim Chaubet
*/
RETURNS VARCHAR(50)
AS
BEGIN 
DECLARE @temp AS VARCHAR(50)
select @temp=
	case	when (@TZ is null or @TZ = 'UTC'		) then 'UTC'
			when @TZ in (	'AFRICA/ADDIS_ABABA',
					'AFRICA/NAIROBI'		) then 'E. Africa Standard Time'			-- +03.00
			when @TZ in (	'AFRICA/ALGIERS',
					'AFRICA/TUNIS'			) then 'Central European Standard Time'		-- +01.00
			when @TZ in (	'AFRICA/BRAZZAVILLE',
					'AFRICA/LAGOS',
					'AFRICA/LUANDA'			) then 'W. Central Africa Standard Time'	-- +01.00
			when @TZ in (	'AFRICA/WINDHOEK'		) then 'Namibia Standard Time'				-- +02.00	missing Central Africa Time in time_zone_info
			when @TZ in (	'AMERICA/ANCHORAGE'		) then 'Alaskan Standard Time'				-- -09.00
			when @TZ in (	'AMERICA/ASUNCION'		) then 'Paraguay Standard Time'				-- -04.00
			when @TZ in (	'AMERICA/BOGOTA',
					'AMERICA/LIMA',
					'AMERICA/LOS_ANGELES'	) then 'SA Pacific Standard Time'			-- -05.00	no DST
			when @TZ in (	'AMERICA/BUENOS_AIRES'	) then 'Argentina Standard Time'			-- -05.00
			when @TZ in (	'AMERICA/COSTA_RICA',	
					'AMERICA/GUATEMALA',
					'AMERICA/TEGUCIGALPA'	) then 'Central Standard Time'				-- -06.00
			when @TZ in (	'AMERICA/DENVER'		) then 'Central America Standard Time'		-- -06.00
			when @TZ in (	'AMERICA/DETROIT',
					'AMERICA/INDIANAPOLIS',
					'AMERICA/NEW_YORK'		) then 'Eastern Standard Time'				-- -05.00
			when @TZ in (	'AMERICA/HALIFAX'		) then 'Atlantic Standard Time'
			when @TZ in (	'AMERICA/MEXICO_CITY'	) then 'Central Standard Time (Mexico)'		-- -06.00
			when @TZ in (	'AMERICA/MIQUELON',													-- -03.00	missing from time_zone_info
					'AMERICA/SAO_PAULO'		) then 'E. South America Standard Time'		-- -03.00	missing from time_zone_info
			when @TZ in (	'AMERICA/MONTEVIDEO'	) then 'Montevideo Standard Time'
			when @TZ in (	'AMERICA/PHOENIX'		) then 'Mountain Standard Time'
			when @TZ in (	'ASIA/ADEN',				
					'ASIA/BAGHDAD',
					'ASIA/KUWAIT',
					'AST',
					'MIDEAST/RIYADH87'		) then 'Arab Standard Time'					-- +03.00
			when @TZ in (	'ASIA/ALMATY'			) then 'N. Central Asia Standard Time'		-- +07.00
			when @TZ in (	'ASIA/AMMAN'			) then 'Jordan Standard Time'				-- +02.00
			when @TZ in (	'ASIA/BAKU'				) then 'Azerbaijan Standard Time'			-- +04.00
			when @TZ in (	'ASIA/BEIRUT',
					'ASIA/DAMASCUS'			) then 'E. Europe Standard Time'			-- +02.00
			when @TZ in (	'ASIA/COLOMBO',
					'ASIA/KOLKATA'			) then 'India Standard Time'				-- +05.30
			when @TZ in (	'ASIA/DHAKA'			) then 'Bangladesh Standard Time'			-- +06.00
			when @TZ in (	'ASIA/DUBAI',
					'ASIA/MUSCAT'			) then 'Arabian Standard Time'				-- +04.00	Gulf Standard time missing from time_zone_info ; =/= Arab or Arabia Standard Time
			when @TZ in (	'ASIA/HONG_KONG',													-- 
					'ASIA/SHANGHAI',
					'ASIA/TAIPEI'			) then 'China Standard Time'				-- +08.00
			when @TZ in (	'ASIA/ISTANBUL'			) then 'Turkey Standard Time'				-- +03.00
			when @TZ in (	'ASIA/KABUL'			) then 'Afghanistan Standard Time'			-- +04.30
			when @TZ in (	'ASIA/KUALA_LUMPUR',
					'ASIA/SINGAPORE'		) then 'Singapore Standard Time'			-- +08.00	Malaysia Time missing from time_zone_info
			when @TZ in (	'ASIA/OMSK'				) then 'Omsk Standard Time'					-- +06.00
			when @TZ in (	'ASIA/TBILISI',														-- +04.00
					'ASIA/YEREVAN'			) then 'Caucasus Standard Time'				--			Armenian standard time missing from time_zone_info
			when @TZ in (	'ASIA/ULAANBAATAR',
					'JAPAN'					) then 'North Asia East Standard Time'		-- +08.00
			when @TZ in (	'ATLANTIC/STANLEY'		) then 'E. South America Standard Time'		-- -03.00	Falkland Islands Standard Time missing from time_zone_info
															--			FLE Standard Time has the wrong offset	
															--			I improvised using ESAST				
			when @TZ in (	'AUSTRALIA/ACT'			) then 'AUS Central Standard Time'			-- +09.30	time zone does not exist. I assumed Australian Central Standard Time
			when @TZ in (	'AUSTRALIA/NORTH'		) then 'AUS Central Standard Time'			-- +09.30	time zone does not exist. I assumed Australian Central Standard Time
			when @TZ in (	'AUSTRALIA/NSW'			) then 'Aus Central W. Standard Time'		-- +08.45	time zone does not exist. I assumed Australian Central Western Standard Time
			when @TZ in (	'AUSTRALIA/QUEENSLAND'	) then 'AUS Eastern Standard Time'			-- +11.00
			when @TZ in (	'AUSTRALIA/SOUTH'		) then 'AUS Central Standard Time'			-- +09.30	time zone does not exist. I assumed Australian Central Standard Time
			when @TZ in (	'AUSTRALIA/VICTORIA'	) then 'AUS Eastern Standard Time'			-- +11.00	Australian Eastern Daylight Savings Time missing from time_zone_info
			when @TZ in (	'AUSTRALIA/WEST'		) then 'W. Australia Standard Time'			-- +08.45	time zone does not exist. I assumed W. Australia Standard Time
			when @TZ in (	'BRAZIL/ACRE'			) then 'SA Pacific Standard Time'			-- -05.00	America/Rio_Branco Time or Acre Time missing from time_zone_info
																--			Improvised using SA Pacific Standard Time
			when @TZ in (	'BRAZIL/EAST'			) then 'SA Pacific Standard Time'			-- -05.00	time zone does not exist. I assumed SA Pacific Standard Time
			when @TZ in (	'BRAZIL/WEST'			) then 'UTC-02'								-- -02.00	time zone does not exist.
																--			Fernando de Noronha Time missing from time_zone_info
			when @TZ in (	'CANADA/ATLANTIC'		) then 'Atlantic Standard Time'				-- -04.00	time zone does not exist.
			when @TZ in (	'CANADA/CENTRAL'		) then 'Central Standard Time'				-- -06.00	time zone does not exist.
			when @TZ in (	'CANADA/EASTERN'		) then 'Eastern Standard Time'				-- -05.00	time zone does not exist.
			when @TZ in (	'CANADA/NEWFOUNDLAND'	) then 'Newfoundland Standard Time'			-- -03.30
			when @TZ in (	'CAT'					) then 'South Africa Standard Time'			-- +02.00	Central Africa Time missing from time_zone_info
			when @TZ in (	'CET'					) then 'Central European Standard Time'		-- +01.00
			when @TZ in (	'CHILE/CONTINENTAL'		) then 'Argentina Standard Time'			-- -03.00	time zone does not exist.
																--			Chile Summer time missing from time_zone_info
																--			Chile Standard Time missing from time_zone_info
			when @TZ in (	'CST'					) then 'Central Standard Time'				-- -06.00
			when @TZ in (	'ECT'					) then 'Atlantic Standard Time'				-- -04.00	Eastern Caribbean Time missing from time_zone_info
																--			Improvised using Atlantic Standard Time
			when @TZ in (	'EET'					) then 'E. Europe Standard Time'			-- +02.00	
			when @TZ in (	'EGYPT'					) then 'Egypt Standard Time'				-- +02.00
			when @TZ in (	'ETC/GMT+10'			) then 'E. Australia Standard Time'			-- +10.00
			when @TZ in (	'ETC/GMT+3'				) then 'E. Africa Standard Time'
			when @TZ in (	'ETC/GMT+4'				) then 'Caucasus Standard Time'
			when @TZ in (	'ETC/GMT+5'				) then 'West Asia Standard Time'
			when @TZ in (	'ETC/GMT+6'				) then 'Central Asia Standard Time'
			when @TZ in (	'ETC/GMT-1'				) then 'Azores Standard Time'
			when @TZ in (	'ETC/GMT-11'			) then 'Samoa Standard Time'				-- +14.00
			when @TZ in (	'ETC/GMT-12'			) then 'Dateline Standard Time'
			when @TZ in (	'ETC/GMT-2'				) then 'Mid-Atlantic Standard Time'
			when @TZ in (	'ETC/GMT-3'				) then 'E. South America Standard Time'
			when @TZ in (	'ETC/GMT-4'				) then 'Pacific SA Standard Time'
			when @TZ in (	'ETC/GMT-5'				) then 'Eastern Standard Time'
			when @TZ in (	'ETC/GMT-6'				) then 'Central America Standard Time'
			when @TZ in (	'ETC/GMT-7'				) then 'Mountain Standard Time'
			when @TZ in (	'ETC/GMT-8'				) then 'Pacific Standard Time'
			when @TZ in (	'ETC/GMT-9'				) then 'Alaskan Standard Time'
			when @TZ in (	'EUROPE/BELGRADE',
					'EUROPE/BERLIN',
					'EUROPE/BRUSSELS',
					'EUROPE/BUCHAREST',
					'EUROPE/MADRID',
					'EUROPE/PARIS'			) then 'Central European Standard Time'
			when @TZ in (	'EUROPE/CHISINAU',
					'EUROPE/HELSINKI',
					'EUROPE/KIEV',
					'EUROPE/MINSK',
					'EUROPE/NICOSIA',
					'EUROPE/RIGA',
					'EUROPE/TALLINN'		) then 'E. Europe Standard Time'
			when @TZ in (	'EUROPE/LONDON',
					'GB'					) then 'Greenwich Standard Time'
			when @TZ in (	'EUROPE/MOSCOW'			) then 'Russian Standard Time'
			when @TZ in (	'INDIAN/ANTANANARIVO'	) then 'E. Africa Standard Time'
			when @TZ in (	'INDIAN/REUNION'		) then 'Caucasus Standard Time'				-- +04.00
			when @TZ in (	'IRAN'					) then 'Iran Standard Time'
			when @TZ in (	'ISRAEL',
					'IST'					) then 'Israel Standard Time'
			when @TZ in (	'PACIFIC/AUCKLAND'		) then 'New Zealand Standard Time'
			when @TZ in (	'PACIFIC/NOUMEA'		) then 'Norfolk Standard Time'
			when @TZ in (	'PACIFIC/TAHITI'		) then 'Hawaiian Standard Time'
			when @TZ in (	'US/CENTRAL'			) then 'Central America Standard Time'
	end
RETURN @temp
END 

GO

-- assuming dim.sys_user exists with column dv_time_zone
use [yourdatabasename];
select distinct(u.dv_time_zone) TZ, dbo.TZtoTimeZone(u.dv_time_zone) TimeZone, tzi.current_utc_offset, tzi.is_currently_dst
from dim.sys_user u
left join sys.time_zone_info tzi on dbo.TZtoTimeZone(u.dv_time_zone) = tzi.name
order by 1;
