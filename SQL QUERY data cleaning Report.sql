select *  
from dbo.[Nashville Housing]

--Standardize Data Format

select saleDate, Convert(date,Saledate)
FROM [Portfolio Project].[dbo].[Nashville Housing]

Update [Nashville Housing]
SET SaleDate = CONVERT(Date,SaleDate)


-- Populate Property Address data

Select *
From [Portfolio Project].[dbo].[Nashville Housing]
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio Project].[dbo].[Nashville Housing] a
JOIN [Portfolio Project].[dbo].[Nashville Housing] b
     on a.ParcelID = b.ParcelID
where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio Project].[dbo].[Nashville Housing] a
JOIN [Portfolio Project].[dbo].[Nashville Housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From [Portfolio Project].[dbo].[Nashville Housing] 
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From [Portfolio Project].[dbo].[Nashville Housing] 

ALTER TABLE NashvilleHousing
Add PropertySplitAddress varchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))





Select *
From [Portfolio Project].[dbo].[Nashville Housing]


Select OwnerAddress
From [Portfolio Project].[dbo].[Nashville Housing]

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [Portfolio Project].[dbo].[Nashville Housing]


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
From [Portfolio Project].[dbo].[Nashville Housing]

-- Change Y and N to Yes and No in "Sold as Vacant" field

select Distinct(Soldasvacant)
From [Portfolio Project].[dbo].[Nashville Housing]
group By Soldasvacant
order by 1

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [Portfolio Project].[dbo].[Nashville Housing]


update [Nashville Housing]
set SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [Portfolio Project].[dbo].[Nashville Housing]


-- Remove Duplicates


Select *,
	ROW_NUMBER() OVER 
	(PARTITION BY ParcelID)
From [Portfolio Project].[dbo].[Nashville Housing]

--Remove Duplicates   


Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [Portfolio Project].[dbo].[Nashville Housing]

--order by ParcelID


select * 
from [Portfolio Project].[dbo].[Nashville Housing]



--Delete Unused Columns

select * 
from [Portfolio Project].[dbo].[Nashville Housing]



ALTER TABLE [Portfolio Project].[dbo].[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

ALTER TABLE [Portfolio Project].[dbo].[Nashville Housing]
DROP COLUMN SaleDate