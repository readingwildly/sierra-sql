SELECT DISTINCT '.' || id2reckey(p.patron_record_id) || 'a' AS patron, v.field_content AS email
FROM sierra_view.hold h 
JOIN sierra_view.patron_record_fullname p ON h.patron_record_id = p.patron_record_id
JOIN sierra_view.record_metadata r ON p.patron_record_id = r.id 
JOIN sierra_view.varfield v ON v.record_id = r.id AND record_type_code = 'p'
WHERE (h.status = 'b' OR h.status = 'i') AND h.pickup_location_code = 'xxx' 
AND v.varfield_type_code = 'z' 
