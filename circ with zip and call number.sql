SET search_path = 'sierra_view';
SELECT b.language_code AS "LANGUAGE",
  CASE
    WHEN c.op_code = 'f' THEN 'Hold'
    WHEN c.op_code = 'o' THEN 'Check Out'
    WHEN c.op_code = 'r' THEN 'Renewal'
    ELSE 'unexpected code '||c.op_code
  END
  AS "ACTION",
  c.itype_code_num AS "I TYPE", 
  CASE
    WHEN c.item_agency_code_num = '1' THEN 'Lib1'
    WHEN c.item_agency_code_num = '2' THEN 'Lib2'
    WHEN c.item_agency_code_num = '3' THEN 'Lib3'
    WHEN c.item_agency_code_num = '4' THEN 'Lib4'
    WHEN c.item_agency_code_num = '5' THEN 'Lib5'
    ELSE 'unexpected code' || c.item_agency_code_num 
  END
  AS "AGENCY", 
  c.item_location_code AS "OWNING LOCATION", 
  c.stat_group_code_num AS "TERMINAL",  
  CASE
    WHEN brp.material_code = '-' THEN 'Video Game'
    WHEN brp.material_code = '2' THEN 'eAudiobook'
    WHEN brp.material_code = '3' THEN 'Playaway'
    WHEN brp.material_code = '4' THEN 'eVideo'
    WHEN brp.material_code = '5' THEN 'eMusic'
    WHEN brp.material_code = '6' THEN 'eJournal'
    WHEN brp.material_code = '7' THEN 'eGovt'
    WHEN brp.material_code = '8' THEN 'eReader'
    WHEN brp.material_code = '9' THEN 'Microform'
    WHEN brp.material_code = '@' THEN 'eBook'
    WHEN brp.material_code = 'a' THEN 'Book'
    WHEN brp.material_code = 'b' THEN 'Braille'
    WHEN brp.material_code = 'bg' THEN 'Board Game'
    WHEN brp.material_code = 'c' THEN 'Printed Music'
    WHEN brp.material_code = 'd' THEN 'Govt Doc'
    WHEN brp.material_code = 'e' THEN 'Maps & Atlases'
    WHEN brp.material_code = 'er1' THEN 'Easy Reader 1'
    WHEN brp.material_code = 'er2' THEN 'Easy Reader 2'
    WHEN brp.material_code = 'er3' THEN 'Easy Reader 3'
    WHEN brp.material_code = 'g' THEN 'DVD'
    WHEN brp.material_code = 'h' THEN 'Audiobook Cassette'
    WHEN brp.material_code = 'i' THEN 'Audiobook CD'
    WHEN brp.material_code = 'j' THEN 'Music CD'
    WHEN brp.material_code = 'k' THEN 'Picture'
    WHEN brp.material_code = 'kit' THEN 'Kit'
    WHEN brp.material_code = 'l' THEN 'Large Print'
    WHEN brp.material_code = 'm' THEN 'Software'
    WHEN brp.material_code = 'n' THEN 'Music Cassette'
    WHEN brp.material_code = 'o' THEN 'Reserve Online'
    WHEN brp.material_code = 'p' THEN 'Mixed Material'
    WHEN brp.material_code = 'q' THEN 'Phonorecord'
    WHEN brp.material_code = 'r' THEN 'Realia'
    WHEN brp.material_code = 'ra' THEN 'Read-Along'
    WHEN brp.material_code = 's' THEN 'Periodical'
    WHEN brp.material_code = 't' THEN 'Manuscript'
    WHEN brp.material_code = 'u' THEN 'Blu-Ray'
    WHEN brp.material_code = 'v' THEN 'VHS'
    WHEN brp.material_code = 'x' THEN 'eResource'
    ELSE 'unexpected code '||brp.material_code
  END
  AS "MAT TYPE",
i.call_number AS "CALL NUMBER",
rm.record_type_code||rm.record_num||'a' AS "BIB RECORD",
p.postal_code AS "ZIP",
to_char(c.transaction_gmt,'YYYY-MM-DD') AS "DATE"
FROM circ_trans c
LEFT JOIN bib_record b ON c.bib_record_id = b.record_id
LEFT JOIN record_metadata rm ON c.bib_record_id = rm.id
LEFT JOIN bib_record_property brp ON c.bib_record_id = brp.bib_record_id
LEFT JOIN item_record_property i ON c.item_record_id = i.item_record_id
LEFT JOIN patron_record_address p ON c.patron_record_id = p.patron_record_id
WHERE c.op_code IN ('f','o','r') AND c.transaction_gmt > '02-01-2021' AND c.transaction_gmt < '03-01-2021'
;
