-- Custom
clientVersion = 792
knightCloseAttackDamageIncreasePercent = 20
paladinRangeAttackDamageIncreasePercent = 15
-- Min/Max rate spawn is a multiplication of the map spawntime in spawns.xml Regular monster spawn time is 600. The formula would be randomValue = random(600*100, 600*200) which varies between 60s and 120s
minRateSpawn = 100
maxRateSpawn = 200

-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 1
pzLocked = 60000
removeChargesFromRunes = true
stairJumpExhaustion = 0
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75
distanceWeaponsDropOnGround = false

-- Skull System
banLength = 2 * 24 * 60 * 60
whiteSkullTime = 15 * 60
redSkullTime = 7 * 24 * 60 * 60
killsDayRedSkull = 3
killsWeekRedSkull = 6
killsMonthRedSkull = 99999
killsDayBanishment = 1
killsWeekBanishment = 12
killsMonthBanishment = 99999

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Welcome to Sabrehaven!"
onePlayerOnlinePerAccount = true
allowClones = false
serverName = "Sabrehaven"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = -1
autoStackCumulatives = false
moneyRate = 1

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = 10

-- Houses
houseRentPeriod = "monthly"

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 1000

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "map"
mapAuthor = "CipSoft"

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = ""
mysqlDatabase = "sabrehaven"
mysqlPort = 3306
mysqlSock = ""

-- Misc.
allowChangeOutfit = true
freePremium = true
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 8
showMonsterLoot = true
blockHeight = false
dropItems = false


-- Character Rooking
-- Level threshold is the level requirement to teleport players back to newbie town
teleportNewbies = true
newbieTownId = 11
newbieLevelThreshold = 5

-- Rates
-- NOTE: rateExp is not used if you have enabled stages in data/XML/stages.xml
rateExp = 1
rateSkill = 3
rateLoot = 2
rateMagic = 2
rateSpawn = 0

-- Monsters
deSpawnRange = 2
deSpawnRadius = 50

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = true

-- Status server information
ownerName = "Erikas"
ownerEmail = ""
url = "https://sabrehaven.com/"
location = "Poland"
