--select astext(geospatialcolumn), * from latestnondeletedaentvalue join latestnondeletedarchent using (uuid);

--select aenttypename, attributeid, attributename from idealaent join aenttype using (aenttypeid) join attributekey using (attributeid);
drop view if exists identifierAsSpreadsheet;
create view identifierAsSpreadsheet as select uuid, group_concat(coalesce(measure || ' ' || vocabname || '(' ||freetext||')',  measure || ' (' || freetext ||')',  vocabname || ' (' || freetext ||')',  measure || ' ' || vocabname ,  vocabname || ' (' || freetext || ')',  measure || ' (' || freetext || ')',  measure,  vocabname,  freetext,  measure,  vocabname,  freetext), ' ') as response from (select * from latestNonDeletedArchentIdentifiers order by attributename) group by uuid;

drop view if exists valueAsSpreadsheet;
create view valueAsSpreadsheet as select uuid, coalesce(measure || ' ' || vocabname || '(' ||freetext||')',  measure || ' (' || freetext ||')',  vocabname || ' (' || freetext ||')',  measure || ' ' || vocabname ,  vocabname || ' (' || freetext || ')',  measure || ' (' || freetext || ')',  measure,  vocabname,  freetext,  measure,  vocabname,  freetext) as response, attributeid, attributename, valuetimestamp from (select * from latestNonDeletedAentValue join attributekey using (attributeid) 
left outer join vocabulary using (vocabid, attributeid) order by uuid, attributename);

--select * from valueAsSpreadsheet;

--select uuid, response as TracklogTeam from valueAsSpreadsheet where attributename = 'TracklogTeam';

.mode list
.header off
/*
select 'left outer join '||group_concat('(select uuid, group_concat(response) as ' || replace(replace(replace(attributename, ' ', '_'),'(',''),')','') || ' from valueAsSpreadsheet where attributename = ''' || attributename || ''' group by uuid)', ' using (uuid) 
left outer join ') || ' using (uuid) ' from idealaent join aenttype using (aenttypeid) join attributekey using (attributeid) where aenttypename = 'Context';
select 'uuid, aenttypename, aenttimestamp, geospatialcolumn, fname ||'' ''|| lname as username, '|| group_concat(replace(replace(replace(attributename, ' ', '_'),'(',''),')','') ,', ') from idealaent join aenttype using (aenttypeid) join attributekey using (attributeid) where aenttypename = 'Context';
*/
.mode csv
.header on

drop view if exists Context;
create view Context as 
select uuid, aenttypename, aenttimestamp as 'modified at', fname ||' '|| lname as 'modified by', Site_Code, Context_ID, AreaCode, Grid_Location_Reference, Date_Opened, Excavation_Method, Elevation_Datum_Type, Highest_Level, Lowest_Level, Target_Spit_Thickness, Minimum_Context_Thickness, Maximum_Context_Thickness, Context_Comments, Artefacts_Present, Soil_Compaction_Type, Soil_Munsell_Colour, Date_Closed, Site_Director_Review, Trench_Supervisor_Review, Bulk_Sample_Mapped, Disturbances, Natural_Formations, Wet_Sieved, Soil_Moisture, Soil_Texture_Actual, Soil_Texture, Bucket_Volume, Deposit_Volume, Final_Bucket_Count, Lowest_Level_Ctr, Lowest_Level_NW, Lowest_Level_SW, Lowest_Level_SE, Lowest_Level_NE, Highest_Level_Ctr, Highest_Level_NW, Highest_Level_SW, Highest_Level_SE, Highest_Level_NE, LotID, Checked_by_Director, Checked_by_Square_Supervisor, Excavators, Structure_Description, Distinguishing_Marks, Photo, Sketch, Your_description, Your_Interpretation, Deposit_Thickness_and_Extent, Deposit_Inclusions, Soil_Colour
from latestnondeletedarchent join aenttype using (aenttypeid) join user using (userid)
left outer join (select uuid, group_concat(response) as Site_Code from valueAsSpreadsheet where attributename = 'Site Code' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Context_ID from valueAsSpreadsheet where attributename = 'Context ID' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as AreaCode from valueAsSpreadsheet where attributename = 'AreaCode' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Grid_Location_Reference from valueAsSpreadsheet where attributename = 'Grid Location Reference' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Date_Opened from valueAsSpreadsheet where attributename = 'Date Opened' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Excavation_Method from valueAsSpreadsheet where attributename = 'Excavation Method' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Elevation_Datum_Type from valueAsSpreadsheet where attributename = 'Elevation Datum Type' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Highest_Level from valueAsSpreadsheet where attributename = 'Highest Level' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Lowest_Level from valueAsSpreadsheet where attributename = 'Lowest Level' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Target_Spit_Thickness from valueAsSpreadsheet where attributename = 'Target Spit Thickness' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Minimum_Context_Thickness from valueAsSpreadsheet where attributename = 'Minimum Context Thickness' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Maximum_Context_Thickness from valueAsSpreadsheet where attributename = 'Maximum Context Thickness' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Context_Comments from valueAsSpreadsheet where attributename = 'Context Comments' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Artefacts_Present from valueAsSpreadsheet where attributename = 'Artefacts Present' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Soil_Compaction_Type from valueAsSpreadsheet where attributename = 'Soil Compaction Type' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Soil_Munsell_Colour from valueAsSpreadsheet where attributename = 'Soil Munsell Colour' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Date_Closed from valueAsSpreadsheet where attributename = 'Date Closed' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Site_Director_Review from valueAsSpreadsheet where attributename = 'Site Director Review' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Trench_Supervisor_Review from valueAsSpreadsheet where attributename = 'Trench Supervisor Review' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Bulk_Sample_Mapped from valueAsSpreadsheet where attributename = 'Bulk Sample Mapped' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Disturbances from valueAsSpreadsheet where attributename = 'Disturbances' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Natural_Formations from valueAsSpreadsheet where attributename = 'Natural Formations' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Wet_Sieved from valueAsSpreadsheet where attributename = 'Wet Sieved' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Soil_Moisture from valueAsSpreadsheet where attributename = 'Soil Moisture' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Soil_Texture_Actual from valueAsSpreadsheet where attributename = 'Soil Texture Actual' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Soil_Texture from valueAsSpreadsheet where attributename = 'Soil Texture' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Bucket_Volume from valueAsSpreadsheet where attributename = 'Bucket Volume' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Deposit_Volume from valueAsSpreadsheet where attributename = 'Deposit Volume' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Final_Bucket_Count from valueAsSpreadsheet where attributename = 'Final Bucket Count' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Lowest_Level_Ctr from valueAsSpreadsheet where attributename = 'Lowest Level Ctr' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Lowest_Level_NW from valueAsSpreadsheet where attributename = 'Lowest Level NW' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Lowest_Level_SW from valueAsSpreadsheet where attributename = 'Lowest Level SW' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Lowest_Level_SE from valueAsSpreadsheet where attributename = 'Lowest Level SE' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Lowest_Level_NE from valueAsSpreadsheet where attributename = 'Lowest Level NE' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Highest_Level_Ctr from valueAsSpreadsheet where attributename = 'Highest Level Ctr' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Highest_Level_NW from valueAsSpreadsheet where attributename = 'Highest Level NW' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Highest_Level_SW from valueAsSpreadsheet where attributename = 'Highest Level SW' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Highest_Level_SE from valueAsSpreadsheet where attributename = 'Highest Level SE' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Highest_Level_NE from valueAsSpreadsheet where attributename = 'Highest Level NE' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as LotID from valueAsSpreadsheet where attributename = 'LotID' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Checked_by_Director from valueAsSpreadsheet where attributename = 'Checked by Director' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Checked_by_Square_Supervisor from valueAsSpreadsheet where attributename = 'Checked by Square Supervisor' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Excavators from valueAsSpreadsheet where attributename = 'Excavators' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Structure_Description from valueAsSpreadsheet where attributename = 'Structure Description' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Distinguishing_Marks from valueAsSpreadsheet where attributename = 'Distinguishing Marks' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Photo from valueAsSpreadsheet where attributename = 'Photo' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Sketch from valueAsSpreadsheet where attributename = 'Sketch' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Your_description from valueAsSpreadsheet where attributename = 'Your description' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Your_Interpretation from valueAsSpreadsheet where attributename = 'Your Interpretation' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Deposit_Thickness_and_Extent from valueAsSpreadsheet where attributename = 'Deposit Thickness and Extent' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Deposit_Inclusions from valueAsSpreadsheet where attributename = 'Deposit Inclusions' group by uuid) using (uuid) 
left outer join (select uuid, group_concat(response) as Soil_Colour from valueAsSpreadsheet where attributename = 'Soil Colour' group by uuid) using (uuid);

select * from context;

