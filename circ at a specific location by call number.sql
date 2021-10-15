SELECT i.call_number
FROM sierra_view.item_record_property i JOIN sierra_view.circ_trans c ON i.item_record_id = c.item_record_id
WHERE c.op_code = 'o' AND (c.stat_group_code_num = '99' OR c.stat_group_code_num = '999')
