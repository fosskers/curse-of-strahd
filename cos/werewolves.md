This section justifies the choice to cut the Werewolf Den from Curse of
Strahd. My three main reasons are:

- Unless you're using the initial Werewolf hook, visiting the Den doesn't advance the story
- There is a low chance of the players needing to visit it via Tarokka
- There are already other sub-groups whose home base is left a mystery

Sunny with Low Chance of Werewolves
-----------------------------------

Out of 40 possible magic item locations, only 1 involves the Den (*5 of
Swords*). Out of 21 possible Strahd enemies, only Zuleika Toranescu is a
werewolf (*Beast / Jack of Diamonds*).

Here is some runnable-as-is Haskell code that demonstrates the chance of
drawing any Werewolf involvement from an ideally random Tarokka reading:

```haskell
import           Data.Ratio
import qualified Data.Set as S

-- | Naive-ish "choice" implementation.
choose :: Int -> Int -> Int
choose a b = product numer `div` product (S.fromList [b, b - 1 .. 1])
  where numer = S.fromList [a, a - 1 .. 1] `S.difference` S.fromList [a - b, a - b - 1 .. 1]

-- | Ways to pick magic item locations.
configs :: Int
configs = 40 `choose` 3  -- 9880

-- | Ways to pick an arrangement that involves the Werewolf Den.
withWWs :: Int
withWWs = 39 `choose` 2  -- 741

-- | Chance of needing to visit the Den for an item.
toTheDen :: Ratio Int
toTheDen = withWWs % configs  -- 0.075 or 7.5%

-- | Chance that Zuleika is the Chosen Enemy of Strahd.
enemyIsZuleika :: Ratio Int
enemyIsZuleika = 1 % (21 `choose` 1)  -- 0.047 or ~5%

-- | Chance of having anything to do with Werewolves. Around 12%.
wwInvolvement :: Ratio Int
wwInvolvement = sum [ toTheDen * (1 - enemyIsZuleika)  -- Item in Den, Zuleika is not enemy
                    , toTheDen * enemyIsZuleika        -- Item in Den, Zuleika is enemy
                    , (1 - toTheDen) * enemyIsZuleika  -- Item not in Den, Zuleikea is enemy
                    ]
```

The `wwInvolvement` function gives us the answer. In any particular Tarokka
drawing, there is only a 12% chance that the players have an explicit
directive to visit the Den.

**"But Yester Hill!"** Yes, well, there is also only a 7.5% chance of
needing to go to Yester Hill for an item, but other factors can draw the
players there, namely restoring the Winery, settling the score with druids,
or interaction with Strahd.

Tarokka Replacements
--------------------

- Enemy: Replace Zuleika with Sergei von Zarovich. Let his text read:

> I see a ghost once betrayed, the seed of evil's power.

- Item: Replace Den with **E5g (Undercroft)**. Maybe? They're almost guaranteed to
go here, and the chest is written as being "unlocked and untrapped". Seems
too easy.

Cons
----

There is no road that leads to the Den. Cutting this section of the
adventure would deprive the players their only legitimate reason to
bush-whack.
