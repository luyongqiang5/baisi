
#import <UIKit/UIKit.h>

typedef enum {
    LYQTopicTypeAll = 1,
    LYQTopicTypePicture = 10,
    LYQTopicTypeWord = 29,
    LYQTopicTypeVoice = 31,
    LYQTopicTypeVideo = 41
}LYQTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const LYQTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const LYQTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const LYQTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const LYQTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const LYQTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureBreakH;