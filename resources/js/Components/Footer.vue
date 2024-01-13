<template>
    <div class="fixed inset-x-0 bottom-0 text-center py-3">
        <n-layout-footer class="bg-transparent shadow">
            <div class="container mx-auto text-center py-4 px-6">
                <span>© {{ new Date().getFullYear() }} ACLC College of Iriga. All rights reserved.</span>
            </div>
        </n-layout-footer>
    </div>
</template>

<script>
import { NLayoutFooter } from 'naive-ui'

export default {
    components: {
        NLayoutFooter
    }
}
</script>
