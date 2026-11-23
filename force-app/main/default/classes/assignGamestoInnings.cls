global class assignGamestoInnings {
   @InvocableMethod
   public static List<List<Inning__c>> run(List<List<Inning__c>> inputInnings) {
      if (inputInnings == null) {
         return inputInnings;
      }

      Set<Decimal> externalGameIds = new Set<Decimal>();
      Map<List<Inning__c>, Decimal> externalIdsByInningList =
         new Map<List<Inning__c>, Decimal>();

      for (List<Inning__c> inningList : inputInnings) {
         if (inningList != null && !inningList.isEmpty() && inningList[0].Game__c != null) {
            try {
               Decimal externalId = parseExternalId(String.valueOf(inningList[0].Game__c));
               externalGameIds.add(externalId);
               externalIdsByInningList.put(inningList, externalId);
            } catch (Exception e) {
               System.debug(LoggingLevel.ERROR,
                  'Invalid Game sports data ID: ' + inningList[0].Game__c);
            }
         }
      }

      Map<Decimal, Id> gameIdByExternalId = new Map<Decimal, Id>();
      if (!externalGameIds.isEmpty()) {
         for (Game__c game : [
            SELECT Id, Game_Sports_Data_ID__c
            FROM Game__c
            WHERE Game_Sports_Data_ID__c IN :externalGameIds
         ]) {
            gameIdByExternalId.put(game.Game_Sports_Data_ID__c, game.Id);
         }
      }

      for (List<Inning__c> inningList : inputInnings) {
         Decimal externalId = externalIdsByInningList.get(inningList);
         Id gameId = gameIdByExternalId.get(externalId);

         if (gameId != null) {
            for (Inning__c inning : inningList) {
               inning.Game__c = gameId;
            }
         }
      }

      return inputInnings;
   }

   private static Decimal parseExternalId(String gameLookupValue) {
      String value = String.valueOf(gameLookupValue);
      value = value.replace(',', '').trim();
      return Decimal.valueOf(value);
   }
}