function pattern_tree()%sub_tpiin,trading_matrix)
st_time=tic;
[sub_tpiin trading_matrix]= sub_tpiin_graph();
counter=1;
for i=1:size(sub_tpiin,1)
    
    tpiin_node = sub_tpiin{i,1};
tpiin_edge = sub_tpiin{i,2};
tpiin_node=unique(tpiin_node);
%-----------Add trading edge in the arc----------------------

for j=1:size(trading_matrix,1)
edge = 0;
    for k=1:size(tpiin_node,1)
    
        if strcmpi(tpiin_node{k,1},trading_matrix{j,1}) || strcmpi(tpiin_node{k,1},trading_matrix{j,2})
    
        edge=edge+1;
    
        end
    end
    
    if edge==2
        
        tpiin_edge{size(tpiin_edge,1)+1,1}=trading_matrix{j,1};
        tpiin_edge{size(tpiin_edge,1),2}=trading_matrix{j,2};
    end
    
end

for j=1:size(tpiin_node,1)

    xx=tpiin_node{j,1};
    degree_count{j,1}=xx;

    indegree=0;

    outdegree=0;

    for k=1:size(tpiin_node,1)
    
        yy=tpiin_edge{k,1};
        if strcmpi(xx,yy)
           indegree=indegree+1; 
        end
    
        yy=tpiin_edge{k,2};
        if strcmpi(xx,yy)
           outdegree=outdegree+1; 
        end
        
    end
    
    indegree_count(j,1)=indegree;
    outdegree_count(j,1)=outdegree;
    
end
 [C I] = sort(indegree_count);
 %[C I] = sort(outdegree_count);
 
 for j=1:size(C,1)
 suspicious_group={};
     if C(j,1)==0
         
        suspicious_group{1,1}=degree_count{I(j,1),1}; 
         
        for k=1:size(tpiin_edge,1)
            
           for m=1:size(suspicious_group,1)
              
               if strcmpi(tpiin_edge{k,1},suspicious_group{m,1})
               
                   suspicious_group{size(suspicious_group,1)+1,1}=tpiin_edge{k,2};
               
               end
           end
            
        end
        if size(suspicious_group,1)>1
        file_pattern{counter,1} = suspicious_group; 
        counter=counter+1;
        end
     end
 end
 
end

[num1,txt1,raw1] = xlsread('final_tpiin_dataset.xls');

final_suspisous={};

counter=1;

for i=1:size(file_pattern,1)
    
   xx= file_pattern{i,1};
   
   
       for k=1:size(txt1,1)
       
          if strcmpi(txt1{k,4},'brown') || strcmpi(txt1{k,4},'yellow') || strcmpi(txt1{k,4},'blue')
           found =0;
           for m=1:size(xx,1)
      
               if strcmpi(xx{m,1},txt1{k,1})||strcmpi(xx{m,1},txt1{k,2})
               
                   found=found+1;
               end
           end
           if found==2
              break; 
           end
           end
       end
       
       if found ==2
       
           %xx
           for ij=1:size(xx,1)
           
               final_suspisous{counter,1}=xx{ij,1};
                
               counter=counter+1;
           end
          
       end
    
end
final_time=toc(st_time);

disp('Execution Time');
final_time
disp('Suspicious Tax Evasion');

size(final_suspisous,1)

R_prediction=unique(final_suspisous);


% for i=1:size(suspicious_node,1)
% R_prediction(i,1) = node_final_count(1,suspicious_node(i,1));
% end
[num1,txt1,raw1] = xlsread('compare_dataset.xls');
work_predict=zeros(size(num1,1),1);

for i=1:size(R_prediction,1)

    for j=1:size(num1,1)
    
    
        if strcmpi( R_prediction(i,1),txt1{j,1})
    
            work_predict(j,1)=1;
        end
    end
end

TP =0;
FN =0;
FP =0;
TN=0;
for i=1:size(work_predict,1)
    chk=0;
    for j=1:size(work_predict,2)

if work_predict(i,j) ==0 && num1(i,j) ==0
    
           TP = TP +1;
        
elseif work_predict(i,j) >0 && num1(i,j) >0
       
        TN = TN +1;
       
elseif work_predict(i,j) >0 && num1(i,j) ==0

            FP = FP +1;
else
     FN = FN +1;
    
end
    end
end

disp('True Positive');

TP
disp('True Negative');

TN
disp('False Negative');

FN

disp('False Positive');

FP

disp('Presision Value');

p=TP/(TP+FP);
disp(p);

disp('Recall Value');

R=TP/(TP+FN);
disp(R);

disp('F-Measure Value');

F=(2*p*R)/(p+R);
disp(F);

disp('Execution Time');
final_time

end