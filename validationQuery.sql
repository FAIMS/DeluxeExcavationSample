select sum(vocabname = '{Soil}')
from latestnondeletedaentreln a join latestnondeletedarchent 
using (uuid) join aenttype using (aenttypeid) join latestnondeletedaentvalue using (uuid) join attributekey using (attributeid) join vocabulary using (vocabid) join latestnondeletedaentreln b using (relationshipid) 
where a.uuid != b.uuid
and attributename = 'Sample Type'
and b.uuid = 1000011401075682340
group by b.uuid
order by relationshipid;


select sum(vocabname = 'Close')
from latestnondeletedaentreln a join latestnondeletedarchent 
using (uuid) join aenttype using (aenttypeid) join latestnondeletedaentvalue using (uuid) join attributekey using (attributeid) join vocabulary using (vocabid) join latestnondeletedaentreln b using (relationshipid) 
where a.uuid != b.uuid
and attributename = 'Scene Type'
and b.uuid = 1000011401075682340
group by b.uuid
order by relationshipid;

select sum(vocabname = 'Open')
from latestnondeletedaentreln a join latestnondeletedarchent 
using (uuid) join aenttype using (aenttypeid) join latestnondeletedaentvalue using (uuid) join attributekey using (attributeid) join vocabulary using (vocabid) join latestnondeletedaentreln b using (relationshipid) 
where a.uuid != b.uuid
and attributename = 'Scene Type'
and b.uuid = 1000011401075682340
group by b.uuid
order by relationshipid;

select uuid, aenttypename from latestnondeletedarchent join aenttype using (aenttypeid);