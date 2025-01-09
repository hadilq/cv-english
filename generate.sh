
ORIGINAL_CV=cv-lashkari.tex
CV=cv-hadi-lashkari-ghouchani.tex
PUBLIC_CV=cv-public-lashkari-mobile.tex

source ./credential-data.sh

cat $ORIGINAL_CV | \
	sed -e "s/CREDENTIAL_PHONE_NUMBER/$CREDENTIAL_PHONE_NUMBER/g" | \
	sed -e "s/CREDENTIAL_ADDRESS/$CREDENTIAL_ADDRESS/g" | \
	sed -e "s/CREDENTIAL_MAILTO/$CREDENTIAL_MAILTO/g" | \
	sed -e "s/CREDENTIAL_EMAIL/$CREDENTIAL_EMAIL/g" | \
	sed -e "s/CREDENTIAL_PARVIZI_MAILTO/$CREDENTIAL_PARVIZI_MAILTO/g" | \
	sed -e "s/CREDENTIAL_PARVIZI_EMAIL/$CREDENTIAL_PARVIZI_EMAIL/g" | \
	sed -e "s/CREDENTIAL_ARIAI_MAILTO/$CREDENTIAL_ARIAI_MAILTO/g" | \
	sed -e "s/CREDENTIAL_ARIAI_EMAIL/$CREDENTIAL_ARIAI_EMAIL/g" | \
	sed -e "s/CREDENTIAL_BENAM_MAILTO/$CREDENTIAL_BENAM_MAILTO/g" | \
	sed -e "s/CREDENTIAL_BENAM_EMAIL/$CREDENTIAL_BENAM_EMAIL/g" > $CV

echo "render the CV"
xelatex $CV

echo "render the public CV"
cat $CV | sed -e 's/\\newcommand{\\ispubliccv}{no}/\\newcommand{\\ispubliccv}{yes}/g' > $PUBLIC_CV

xelatex $PUBLIC_CV

rm $CV $PUBLIC_CV
