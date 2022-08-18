*===============================================================================
* Program: pencode.ado
* Purpose: encode the province to a tidy format and generate e-m-w variable
* Version: 1.0 (2020/03/21)
* Author:  Devin Chu
* Website: http://www.github.com/zhbsis/pencode
*===============================================================================

/*

*/

capture program drop pencode

// pencode Function
program define pencode
version 14.0
syntax [if] [in], id(string) GENregion(string)

	qui replace `id' = "北京" if strmatch(`id', "*北京*") 
	qui replace `id' = "天津" if strmatch(`id', "*天津*") 
	qui replace `id' = "河北" if strmatch(`id', "*河北*") 
	qui replace `id' = "山西" if strmatch(`id', "*山西*") 
	qui replace `id' = "辽宁" if strmatch(`id', "*辽宁*") 
	qui replace `id' = "吉林" if strmatch(`id', "*吉林*") 
	qui replace `id' = "上海" if strmatch(`id', "*上海*") 
	qui replace `id' = "江苏" if strmatch(`id', "*江苏*") 
	qui replace `id' = "浙江" if strmatch(`id', "*浙江*") 
	qui replace `id' = "安徽" if strmatch(`id', "*安徽*") 
	qui replace `id' = "福建" if strmatch(`id', "*福建*") 
	qui replace `id' = "江西" if strmatch(`id', "*江西*") 
	qui replace `id' = "山东" if strmatch(`id', "*山东*") 
	qui replace `id' = "河南" if strmatch(`id', "*河南*") 
	qui replace `id' = "湖北" if strmatch(`id', "*湖北*") 
	qui replace `id' = "湖南" if strmatch(`id', "*湖南*") 
	qui replace `id' = "广东" if strmatch(`id', "*广东*") 
	qui replace `id' = "广西" if strmatch(`id', "*广西*") 
	qui replace `id' = "海南" if strmatch(`id', "*海南*") 
	qui replace `id' = "重庆" if strmatch(`id', "*重庆*") 
	qui replace `id' = "四川" if strmatch(`id', "*四川*") 
	qui replace `id' = "贵州" if strmatch(`id', "*贵州*") 
	qui replace `id' = "云南" if strmatch(`id', "*云南*") 
	qui replace `id' = "西藏" if strmatch(`id', "*西藏*")
	qui replace `id' = "陕西" if strmatch(`id', "*陕西*")
	qui replace `id' = "甘肃" if strmatch(`id', "*甘肃*")
	qui replace `id' = "青海" if strmatch(`id', "*青海*")
	qui replace `id' = "宁夏" if strmatch(`id', "*宁夏*")
	qui replace `id' = "新疆" if strmatch(`id', "*新疆*")
	qui replace `id' = "黑龙江" if strmatch(`id', "*黑龙江*") 
	qui replace `id' = "内蒙古" if strmatch(`id', "*内蒙古*")
		
	* est region
	qui gen `genregion'1_1 = inlist(`id', "辽宁","河北","北京","天津","山东")            // 东部1
	qui gen `genregion'1_2 = inlist(`id', "江苏","上海","浙江","福建","广东","海南")     // 东部2
	qui gen `genregion'1 = `genregion'1_1+`genregion'1_2
	* central region
	qui gen `genregion'2 = inlist(`id', "山西","河南","安徽","湖北","江西","湖南","吉林","黑龙江") // 中部
	* west region
	qui gen `genregion'3_1 = inlist(`id', "陕西","四川","云南","贵州","广西","甘肃")     // 西部1
	qui gen `genregion'3_2 = inlist(`id', "青海","宁夏","西藏","新疆","内蒙古","重庆")     // 西部2
	qui gen `genregion'3 = `genregion'3_1+`genregion'3_2     // 西部2
	qui drop `genregion'1_1 `genregion'1_2 `genregion'3_1 `genregion'3_2
	
	
	label var `genregion'1 "东部地区"
	label var `genregion'2 "中部地区"
	label var `genregion'3 "西部地区"
	
	qui gen     `genregion' = 1 if `genregion'1==1   // 东部地区
	qui replace `genregion' = 2 if `genregion'2==1   // 中部地区
	qui replace `genregion' = 3 if `genregion'3==1   // 西部地区
	
	local regionValue "regionValue"
	label define `regionValue' 1 "东部地区" 2 "中部地区" 3 "西部地区"
	label values `genregion' `regionValue'
	label var `genregion' "东中西虚拟变量"
	
end	