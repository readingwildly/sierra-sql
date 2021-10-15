SELECT CONCAT('p',p.record_num) AS "pnumber", CONCAT(pn.last_name, ', ',pn.first_name) AS "PatronName", pa.addr1 AS "PatronStreet1", pa.addr2 AS "PatronStreet2", pa.city AS "PatronCity", pa.region AS "PatronState", pa.postal_code AS "PatronZip"
FROM sierra_view.patron_view p
JOIN sierra_view.patron_record_fullname pn ON p.id = pn.patron_record_id
JOIN sierra_view.patron_record_address pa ON pn.patron_record_id = pa.patron_record_id
WHERE (p.patron_agency_code_num = 3 OR p.patron_agency_code_num = 5 OR p.ptype_code = 80 OR p.ptype_code= 81)
AND pa.city IS NOT NULL
AND pa.patron_record_address_type_id = 1
;