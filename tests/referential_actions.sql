USE AutoPartsStore;
GO

-----no action delete -> trying to delete parrent(brand) that has children(models)

SELECT * FROM CarBrand WHERE Brand_ID = 1;
SELECT * FROM CarModel WHERE Brand_ID = 1;

DELETE FROM CarBrand WHERE Brand_ID = 1;

----- no action update -> updating primary keys should not be possible
UPDATE CarBrand SET Brand_ID = 999 WHERE Brand_ID = 1;

---- cascade deleting -> generation options should be deleted when generation is deleted
SELECT * FROM ModelGeneration WHERE ModelGeneration_ID = 1;
SELECT * FROM GenerationOption WHERE Generation_ID = 1;

DELETE FROM ModelGeneration WHERE ModelGeneration_ID = 1;

SELECT * FROM ModelGeneration WHERE ModelGeneration_ID = 1;
SELECT * FROM GenerationOption WHERE Generation_ID = 1;

-------------cascade updating
SELECT * FROM BodyType WHERE BodyName = 'Hatchback';
SELECT * FROM GenerationOption WHERE BodyName = 'Hatchback';

UPDATE BodyType SET BodyName = 'HatchbackDeluxe' WHERE BodyName = 'Hatchback';

SELECT * FROM BodyType WHERE BodyName = 'HatchbackDeluxe';
SELECT * FROM GenerationOption WHERE BodyName = 'HatchbackDeluxe';