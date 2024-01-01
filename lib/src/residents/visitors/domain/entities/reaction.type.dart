import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';

enum REACTION_TYPE {
  reaction_angry,
  reaction_laughing,
  reaction_sad,
  reaction_suprised,
  reaction_like,
  reaction_love
}

class ReactionType {
  static REACTION_TYPE getTypeFromText(String type) {
    switch (type) {
      case 'reaction_angry':
        return REACTION_TYPE.reaction_angry;
      case 'reaction_laughing':
        return REACTION_TYPE.reaction_laughing;
      case 'reaction_love':
        return REACTION_TYPE.reaction_love;
      case 'reaction_sad':
        return REACTION_TYPE.reaction_sad;
      case 'reaction_suprised':
        return REACTION_TYPE.reaction_suprised;
      default:
        return REACTION_TYPE.reaction_like;
    }
  }

  static String getTypeText(REACTION_TYPE type) {
    switch (type) {
      case REACTION_TYPE.reaction_angry:
        return 'reaction_angry';
      case REACTION_TYPE.reaction_laughing:
        return 'reaction_laughing';
      case REACTION_TYPE.reaction_like:
        return 'reaction_like';
      case REACTION_TYPE.reaction_love:
        return 'reaction_love';
      case REACTION_TYPE.reaction_sad:
        return 'reaction_sad';
      case REACTION_TYPE.reaction_suprised:
        return 'reaction_suprised';
    }
  }

  static String getEmoji(REACTION_TYPE type) {
    switch (type) {
      case REACTION_TYPE.reaction_angry:
        return '😡';
      case REACTION_TYPE.reaction_laughing:
        return '😂';
      case REACTION_TYPE.reaction_like:
        return '👍🏻';
      case REACTION_TYPE.reaction_love:
        return '💕';
      case REACTION_TYPE.reaction_sad:
        return '😥';
      case REACTION_TYPE.reaction_suprised:
        return '😯';
    }
  }

  static ComplaintEntity getAdjustedComplaint(
      ComplaintEntity complaintEntity, String typeText) {
    //
    ComplaintEntity complaint = complaintEntity;
    //
    switch (typeText) {
      case 'reaction_angry':
        complaint.vote_count_angry = (complaint.vote_count_angry ?? 0) + 1;
        return complaint;
      case 'reaction_laughing':
        complaint.vote_count_laughing =
            (complaint.vote_count_laughing ?? 0) + 1;
        return complaint;
      case 'reaction_love':
        complaint.vote_count_love = (complaint.vote_count_love ?? 0) + 1;
        return complaint;
      case 'reaction_sad':
        complaint.vote_count_sad = (complaint.vote_count_sad ?? 0) + 1;
        return complaint;
      case 'reaction_suprised':
        complaint.vote_count_suprised =
            (complaint.vote_count_suprised ?? 0) + 1;
        return complaint;
      default:
        complaint.vote_count_like = (complaint.vote_count_like ?? 0) + 1;
        return complaint;
    }
  }

  static CommentEntity getAdjustedComment(
      CommentEntity commentEntity, String typeText) {
    //
    CommentEntity comment = CommentEntity();
    //
    switch (typeText) {
      case 'reaction_angry':
        comment.vote_count_angry = (comment.vote_count_angry ?? 0) + 1;
        return comment;
      case 'reaction_laughing':
        comment.vote_count_laughing = (comment.vote_count_laughing ?? 0) + 1;
        return comment;
      case 'reaction_love':
        comment.vote_count_love = (comment.vote_count_love ?? 0) + 1;
        return comment;
      case 'reaction_sad':
        comment.vote_count_sad = (comment.vote_count_sad ?? 0) + 1;
        return comment;
      case 'reaction_suprised':
        comment.vote_count_suprised = (comment.vote_count_suprised ?? 0) + 1;
        return comment;
      default:
        comment.vote_count_like = (comment.vote_count_like ?? 0) + 1;
        return comment;
    }
  }

  static String getText(REACTION_TYPE type) {
    switch (type) {
      case REACTION_TYPE.reaction_angry:
        return 'I\'m angry';
      case REACTION_TYPE.reaction_laughing:
        return 'I\'m laughing';
      case REACTION_TYPE.reaction_sad:
        return 'I\'m sad';
      case REACTION_TYPE.reaction_suprised:
        return 'I\'m suprised';
      case REACTION_TYPE.reaction_love:
        return 'I love this';
      default:
        return 'I like this';
    }
  }
}
