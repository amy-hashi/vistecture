#!/bin/sh


echo "clear result folder..."
mkdir -p result
rm -rf result
mkdir -p result


echo "generate new documentation..."
vistecture --config=pTFE validate || exit 1
vistecture --config=pTFE documentation --templatePath=templates/htmldocumentation.tmpl --iconPath=templates/icons > result/documentation.html


echo "generate minmal graphs..."
vistecture --config=pTFE --project="pTFE minimal" --skipValidation=1 graph --iconPath=../templates/icons   --hidePlanned=1 | dot -Tpng -Gbgcolor=white -o result/graphmin.png

echo "generate graphs with planned..."
vistecture --config=pTFE graph --iconPath=templates/icons | dot -Tpng -Gbgcolor=white -o result/graphfull.png


echo "generate teamgraph (detail)."
vistecture --config=pTFE teamGraph  | dot -Tpng -Gbgcolor=white -o result/teamGraph.png

echo "generate teamgraph (summary)."
vistecture --config=pTFE teamGraph  --summaryRelation 1 | dot -Tpng -Gbgcolor=white -o result/teamGraphSummary.png


echo "generate (impact analyze)..."
vistecture --config=pTFE analyze > result/impact.txt

echo "generate (application-list)..."
vistecture --config=pTFE documentation --templatePath=templates/application-properties.tmpl --iconPath=templates/icons > result/application-properties.html

echo "copy static assets so that they are displayed in svg in the html doc."
cp -R templates/icons result/templates/
