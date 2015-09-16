﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "quat_s";
            var aPop = new Array(['txtCustno', '', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtSalesno', '', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);

                $('#txtBdate').focus();
                
                //104/08/31 業務只能看到自己的
            	q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 0, 0, "sales_vcc");
            }
            
            var sales_issales='',sales_job='',sales_group='';
            function q_gtPost(t_name) {
                switch (t_name) {
					case 'sales_vcc':
	                    as = _q_appendData('sss', '', true);
	                    if (as[0] != undefined) {
	                    	sales_issales=as[0].issales;
	                    	sales_job=as[0].job;
	                    	sales_group=as[0].salesgroup;
	                    }
	                    break;
                }
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_custno = $('#txtCustno').val();
                t_salesno = $('#txtSalesno').val();
                t_sales = $('#txtSales').val();
                t_comp = $('#txtComp').val();
                t_postname = $('#txtPostname').val();

                t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
                /// 100.  .
                t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
                /// 100.  .

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("comp", t_comp) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("salesno", t_salesno) + q_sqlPara2("custno", t_custno) + q_sqlPara2("postname", t_postname);
                
                if (sales_issales == 'true' && sales_job.indexOf('經理') < 0 && r_rank <= '5') {//一般業務只能看到自己的出貨單
	               	t_where += " and salesno='"+r_userno+"' ";
                }else if (sales_issales == 'true' && sales_job.indexOf('經理') > -1 && r_rank <= '5') {
                	t_where += " and salesno in (select noa from sss where  salesgroup='"+sales_group+"') ";
                }

                if (t_sales.length > 0)
                    t_where = t_where + "and left( sales," + t_sales.length + ")=N'" + t_sales + "'";

                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'> </a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
					<td>
						<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
						&nbsp;
						<input class="txt" id="txtComp" type="text" style="width:115px;font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSales'> </a></td>
					<td>
						<input class="txt" id="txtSalesno" type="text" style="width:90px; font-size:medium;" />
						&nbsp;
						<input class="txt" id="txtSales" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPostname'> </a></td>
					<td><input class="txt" id="txtPostname" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>

