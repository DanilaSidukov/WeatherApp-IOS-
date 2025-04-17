import Foundation
import SwiftUI

protocol RefreshDelegate {
    
    func onRefreshAction()
}

final class RefreshControl : UIRefreshControl {
    
    private var refreshDelegate: RefreshDelegate?
    
    convenience init (
        delegate: RefreshDelegate
    ) {
        self.init()
        self.refreshDelegate = delegate
        self.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc private func handleRefresh() {
        self.refreshDelegate?.onRefreshAction()
    }
}
