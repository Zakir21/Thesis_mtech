function algorithm_one()

%construct the TPIIN network-----------------------

[num1,txt1,raw1] = xlsread('Product_buyer_dataset.xls');

TPIIN = {'V','Ev2','Vcolor','Ecolor'};
%-------person vertex: green, Company vertex: Red, trading edge: blue,
%trading influence: black, kinship relation: brown.

color_defination={};
i=1;
for ii=2:size(txt1,1)
    
   if size(txt1{ii,3} ,2)>1
       
      TPIIN{i,1}=txt1{ii,2};
      
      TPIIN{i,2}=txt1{ii,3};
      
      TPIIN{i,3}='green';
      
      TPIIN{i,4}='brown';
      i=i+1;
   end
end

[num1,txt1,raw1] = xlsread('person_interlock_dataset.xls');

for ii=2:size(txt1,1)

    for j=3:size(txt1,2)
    
   if size(txt1{ii,j} ,2)>1
       
      TPIIN{i,1}=txt1{ii,2};
      
      TPIIN{i,2}=txt1{ii,j};
      
      TPIIN{i,3}='green';
      
      TPIIN{i,4}='yellow';
      i=i+1;
   end
   
    end
end
[num1,txt1,raw1] = xlsread('company_person_dataset.xls');

for ii=2:size(txt1,1)

    for j=3:2:size(txt1,2)
    
   if size(txt1{ii,j} ,2)>1
       
      TPIIN{i,1}=txt1{ii,2};
      
      TPIIN{i,2}=txt1{ii,j};
      
      TPIIN{i,3}='red';
      
      TPIIN{i,4}='blue';
      i=i+1;
   end
   
    end
end

[num1,txt1,raw1] = xlsread('company_investment_dataset.xls');

for ii=2:size(txt1,1)

    for j=3:size(txt1,2)
    
   if size(txt1{ii,j} ,2)>1
       
      TPIIN{i,1}=txt1{ii,2};
      
      TPIIN{i,2}=txt1{ii,j};
      
      TPIIN{i,3}='red';
      
      TPIIN{i,4}='blue';
      i=i+1;
   end
   
    end
end


[num1,txt1,raw1] = xlsread('company_transaction_dataset.xls');

for ii=2:size(txt1,1)

    for j=3:size(txt1,2)
    
   if size(txt1{ii,j} ,2)>1
       
      TPIIN{i,1}=txt1{ii,2};
      
      TPIIN{i,2}=txt1{ii,j};
      
      TPIIN{i,3}='red';
      
      TPIIN{i,4}='black';
      i=i+1;
   end
   
    end
end

xlswrite('final_tpiin_dataset.xls', TPIIN, 1, 'E1');


end

