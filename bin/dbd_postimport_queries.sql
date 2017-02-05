DELETE FROM z_decked_cards WHERE cardset IN (
    "Masters Edition",
    "Masters Edition II",
    "Masters Edition III",
    "Masters Edition IV"
);

ALTER TABLE z_decked_cards ADD ccn VARCHAR(5) NOT NULL AFTER mvid;
ALTER TABLE z_decked_cards ADD edition VARCHAR(10) NOT NULL AFTER mvid;
ALTER TABLE z_decked_cards ADD rarity2 VARCHAR(10) NOT NULL;
ALTER TABLE z_decked_cards ADD isplane INT(1) NOT NULL DEFAULT '0' AFTER issnow;
ALTER TABLE z_decked_cards ADD isscheme INT(1) NOT NULL DEFAULT '0' AFTER isplane;

UPDATE z_decked_cards SET rarity = 'O' WHERE rarity = 'Special';
UPDATE z_decked_cards SET rarity = 'L' WHERE rarity = 'Basic Land';
UPDATE z_decked_cards SET rarity = 'C' WHERE rarity = 'Common';
UPDATE z_decked_cards SET rarity = 'U' WHERE rarity = 'Uncommon';
UPDATE z_decked_cards SET rarity = 'R' WHERE rarity = 'Rare';
UPDATE z_decked_cards SET rarity = 'M' WHERE rarity = 'Mythic Rare';
UPDATE z_decked_cards SET rarity2 = rarity;
UPDATE z_decked_cards SET cardname = REPLACE(cardname, 'AEther', 'Æther');
UPDATE z_decked_cards SET cardset = "Commander" where cardset = "Magic: The Gathering-Commander";
UPDATE z_decked_cards z SET edition = (SELECT edition FROM cardsets WHERE name = z.cardset);
UPDATE z_decked_cards SET ccn = cardnumber;
-- UPDATE z_decked_cards z SET ccn = (SELECT ccn FROM cards WHERE cardname = z.cardname AND edition = z.edition ORDER BY ccn LIMIT 1);
-- UPDATE z_decked_cards z SET ccn = (SELECT ccn FROM cards WHERE mvid = z.mvid ORDER BY ccn LIMIT 1) WHERE ccn LIKE '';
-- ALTER TABLE z_decked_cards DROP cardset;

ALTER TABLE z_decked_cards DROP colororder;
ALTER TABLE z_decked_cards DROP ismodern;
ALTER TABLE z_decked_cards DROP islegacy;
ALTER TABLE z_decked_cards DROP isstandard;
ALTER TABLE z_decked_cards DROP isextended;
ALTER TABLE z_decked_cards DROP isedh;
ALTER TABLE z_decked_cards DROP specialtype;
ALTER TABLE z_decked_cards DROP transformid;
ALTER TABLE z_decked_cards DROP setorder;
ALTER TABLE z_decked_cards DROP prodblue;
ALTER TABLE z_decked_cards DROP prodblack;
ALTER TABLE z_decked_cards DROP prodwhite;
ALTER TABLE z_decked_cards DROP prodgreen;
ALTER TABLE z_decked_cards DROP prodred;
ALTER TABLE z_decked_cards DROP prodcolorless;
ALTER TABLE z_decked_cards DROP prodany;
ALTER TABLE z_decked_cards DROP artist;
ALTER TABLE z_decked_cards DROP cardnumber;
ALTER TABLE z_decked_cards DROP rarity;
ALTER TABLE z_decked_cards CHANGE rarity2 rarity VARCHAR(10);

