function decode_row(rowstr) { return parseInt(unfix_row(rowstr),10) - 1; }
function encode_row(row) { return "" + (row + 1); }
function fix_row(cstr) { return cstr.replace(/([A-Z]|^)(\d+)$/,"$1$$$2"); }
function unfix_row(cstr) { return cstr.replace(/\$(\d+)$/,"$1"); }

function decode_col(colstr) { var c = unfix_col(colstr), d = 0, i = 0; for(; i !== c.length; ++i) d = 26*d + c.charCodeAt(i) - 64; return d - 1; }
function encode_col(col) { var s=""; for(++col; col; col=Math.floor((col-1)/26)) s = String.fromCharCode(((col-1)%26) + 65) + s; return s; }
function fix_col(cstr) { return cstr.replace(/^([A-Z])/,"$$$1"); }
function unfix_col(cstr) { return cstr.replace(/^\$([A-Z])/,"$1"); }

function split_cell(cstr) { return cstr.replace(/(\$?[A-Z]*)(\$?\d*)/,"$1,$2").split(","); }
function decode_cell(cstr) { var splt = split_cell(cstr); return { c:decode_col(splt[0]), r:decode_row(splt[1]) }; }
function encode_cell(cell) { return encode_col(cell.c) + encode_row(cell.r); }
function fix_cell(cstr) { return fix_col(fix_row(cstr)); }
function unfix_cell(cstr) { return unfix_col(unfix_row(cstr)); }
function decode_range(range) { var x =range.split(":").map(decode_cell); return {s:x[0],e:x[x.length-1]}; }
function encode_range(cs,ce) {
	if(ce === undefined || typeof ce === 'number') return encode_range(cs.s, cs.e);
	if(typeof cs !== 'string') cs = encode_cell(cs); if(typeof ce !== 'string') ce = encode_cell(ce);
	return cs == ce ? cs : cs + ":" + ce;
}

function safe_decode_range(range) {
	var o = {s:{c:0,r:0},e:{c:0,r:0}};
	var idx = 0, i = 0, cc = 0;
	var len = range.length;
	for(idx = 0; i < len; ++i) {
		if((cc=range.charCodeAt(i)-64) < 1 || cc > 26) break;
		idx = 26*idx + cc;
	}
	o.s.c = --idx;

	for(idx = 0; i < len; ++i) {
		if((cc=range.charCodeAt(i)-48) < 0 || cc > 9) break;
		idx = 10*idx + cc;
	}
	o.s.r = --idx;

	if(i === len || range.charCodeAt(++i) === 58) { o.e.c=o.s.c; o.e.r=o.s.r; return o; }

	for(idx = 0; i != len; ++i) {
		if((cc=range.charCodeAt(i)-64) < 1 || cc > 26) break;
		idx = 26*idx + cc;
	}
	o.e.c = --idx;

	for(idx = 0; i != len; ++i) {
		if((cc=range.charCodeAt(i)-48) < 0 || cc > 9) break;
		idx = 10*idx + cc;
	}
	o.e.r = --idx;
	return o;
}

function safe_format_cell(cell, v) {
	if(cell.z !== undefined) try { return (cell.w = SSF.format(cell.z, v)); } catch(e) { }
	if(!cell.XF) return v;
	try { return (cell.w = SSF.format(cell.XF.ifmt||0, v)); } catch(e) { return ''+v; }
}

function format_cell(cell, v) {
	if(cell == null || cell.t == null) return "";
	if(cell.w !== undefined) return cell.w;
	if(v === undefined) return safe_format_cell(cell, cell.v);
	return safe_format_cell(cell, v);
}


function sheet_to_row(sheet, opts) {
	var out = [], txt = "", qreg = /"/g;
	var o = opts == null ? {} : opts;
	if(sheet == null || sheet["!ref"] == null) return "";
	var r = safe_decode_range(sheet["!ref"]);
	var FS = o.FS !== undefined ? o.FS : ",", fs = FS.charCodeAt(0);
	var RS = o.RS !== undefined ? o.RS : "\n", rs = RS.charCodeAt(0);
	var row = "", rr = "", cols = [];
	var i = 0, cc = 0, val;
	var R = 0, C = 0;
	for(C = r.s.c; C <= r.e.c; ++C) cols[C] = encode_col(C);
	for(R = r.s.r; R <= r.e.r; ++R) {
		row = [];
		rr = encode_row(R);
		for(C = r.s.c; C <= r.e.c; ++C) {
			val = sheet[cols[C] + rr];
			txt = val !== undefined ? ''+format_cell(val) : "";
			for(i = 0, cc = 0; i !== txt.length; ++i) {
        if((cc = txt.charCodeAt(i)) === fs || cc === rs || cc === 34) {
			      txt = "\"" + txt.replace(qreg, '""') + "\"";
            break;
        }
      }
      var x = txt;
			row.push(x);
		}
		out.push(row);
	}
	return out;
}
